package com.sulake.habbo.configuration {
    import com.sulake.core.assets.AssetLoaderStruct
    import com.sulake.core.assets.IAsset
    import com.sulake.core.assets.IAssetLibrary
    import com.sulake.core.assets.TextAsset
    import com.sulake.core.assets.loaders.AssetLoaderEvent
    import com.sulake.core.class_79
    import com.sulake.core.runtime.Component
    import com.sulake.core.runtime.ComponentDependency
    import com.sulake.core.runtime.IContext
    import com.sulake.core.runtime.ICore
    import com.sulake.core.runtime.ICoreConfiguration
    import com.sulake.core.utils.ErrorReportStorage
    import com.sulake.habbo.localization.IHabboLocalizationManager
    import com.sulake.habbo.utils.CommunicationUtils
    import com.sulake.habbo.utils.HabboWebTools
    import com.sulake.iid.IIDHabboLocalizationManager

    import flash.events.Event
    import flash.net.URLRequest
    import flash.system.Security
    import flash.utils.ByteArray
    import flash.utils.Dictionary

    public class HabboConfigurationManager extends Component implements ICoreConfiguration, IHabboConfigurationManager {

        private static const INTERPOLATION_DEPTH_LIMIT: int = 3;
        private static const REPLACE_CHAR: String = "%";

        private var isConfigReadOnly: Boolean = false;
        private var isConfigLoaded: Boolean = false; // 527
        private var someBool: Boolean = false;
        private var useHttps: Boolean = false;
        private var configurationData: Dictionary;
        private var configurationKeys: Array;
        private var environmentId: String;
        private var _localization: IHabboLocalizationManager;

        public function HabboConfigurationManager(context: IContext, flags: uint = 0, assets: IAssetLibrary = null) {
            super(context, flags, assets);
            context.configuration = this;
            isConfigReadOnly = ((flags & 0x10000000) > 0);
            someBool = ((flags & 0x01000000) > 0);
            lock();
            resetAll();
            if (!propertyExists("environment.id") && CommunicationUtils.propertyExists("environment")) {
                updateEnvironmentId(CommunicationUtils.readSOLString("environment"));
            }
        }

        override protected function get dependencies(): Vector.<ComponentDependency> {
            return super.dependencies.concat(new <ComponentDependency>[
                new ComponentDependency(new IIDHabboLocalizationManager(), function (localization: IHabboLocalizationManager): void {
                    _localization = localization;
                }, false, [{"type":"complete", "callback":onLocalizationComplete}])
            ]);
        }

        private function onLocalizationComplete(event: Event): void {
            initConfigurationDownload();
        }

        public function updateEnvironmentId(envId: String): void {
            if (environmentId != envId) {
                environmentId = envId;
                setProperty("environment.id", envId);
                updateEnvironmentVariables();
            }
            initEmbeddedConfigurations();
            setDefaults();
        }

        public function resetAll(): void {
            isConfigLoaded = false;
            configurationData = new Dictionary();
            configurationKeys = [];
            parseDevelopmentVariables();
            parseCommonVariables();
            parseLocalizationVariables();
            setProperty("flash.client.url", "app:/");
            parseArguments();
            setDefaults();
            updateEnvironmentVariables();
            if (!propertyExists("environment.id")) {
                initEmbeddedConfigurations();
            }
            if (!isConfigLoaded && isConfigReadOnly) {
                isConfigLoaded = true;
                unlock();
                events.dispatchEvent(new Event("complete"));
            } else if (!isConfigLoaded && someBool) {
                initConfigurationDownload();
            }
        }

        override public function dispose(): void {
            super.dispose();
        }

        public function isInitialized(): Boolean {
            return isConfigLoaded;
        }

        private function updateEnvironmentVariables(): void {
            const keysToUpdate: Array = [
                "connection.info.host",
                "connection.info.port",
                "url.prefix",
                "site.url",
                "flash.dynamic.download.url",
                "flash.dynamic.download.name.template",
                "flash.dynamic.avatar.download.configuration",
                "flash.dynamic.avatar.download.url",
                "pocket.api",
                "web.api",
                "facebook.application.id",
                "web.terms_of_service.link"
            ];

            for each (var key: String in keysToUpdate) {
                var defaultValue: String = getProperty(key);
                var envKey: String = key + "." + environmentId;
                if (propertyExists(envKey)) {
                    var envValue: String = getProperty(envKey);
                    setProperty(key, envValue);
                } else {
                    setProperty(key, defaultValue);
                }
            }
        }

        override public function propertyExists(key: String): Boolean {
            return configurationData[key] != null;
        }

        override public function getProperty(key: String, params: Dictionary = null): String {
            var value: String = configurationData[key] as String;
            value = interpolate(value);
            if (value == null) {
                return "";
            }
            if (value.substr(0, 2) == "//") {
                value = (useHttps ? "https:" : "http:") + value;
            }
            value = updateUrlProtocol(value);
            if (params != null) {
                value = fillParams(value, params);
            }
            return value;
        }

        override public function setProperty(key: String, value: String, persistent: Boolean = false, log: Boolean = false): void {
            if (log && configurationData[key] == null) {
                class_14.log(key + "=" + value);
            }
            if (configurationKeys.indexOf(key) < 0 || persistent) {
                configurationData[key] = value;
            }
            if (persistent) {
                configurationKeys.push(key);
            }
        }

        override public function getBoolean(key: String): Boolean {
            var value: String = configurationData[key] as String;
            return value != null && (value == "1" || value.toLowerCase() == "true");
        }

        override public function getInteger(key: String, defaultValue: int): int {
            var value: String = configurationData[key] as String;
            return value == null ? defaultValue : int(value);
        }

        override public function updateUrlProtocol(url: String): String {
            return useHttps ? url.replace("http://", "https://").replace(":8090/", ":8443/") : url;
        }

        override public function interpolate(value: String): String {
            if (value == null) {
                return null;
            }

            const regex: RegExp = /\${([^}]*)}/g;
            var interpolated: String = value;
            var limit: int = INTERPOLATION_DEPTH_LIMIT;

            while (limit-- > 0) {
                var result: Array = [];
                var match: Object;
                var lastIndex: int = 0;
                var buffer: String = "";

                while ((match = regex.exec(interpolated)) != null) {
                    if (!propertyExists(match[1])) {
                        return null;
                    }
                    buffer += interpolated.substring(lastIndex, match.index);
                    buffer += getProperty(match[1]);
                    lastIndex = match.index + match[0].length;
                }

                buffer += interpolated.substring(lastIndex);
                if (buffer == interpolated) {
                    break;
                }

                interpolated = buffer;
            }

            return interpolated;
        }

        public function initConfigurationDownload(): void {
            var assetLoader: AssetLoaderStruct;
            var request: URLRequest;
            var assetName: String;

            isConfigLoaded = false;

            assetName = _localization == null ? getProperty("external.variables.txt") :
                    "variables_" + _localization.getActiveEnvironmentId().toLowerCase() + "_" + _localization.getExternalVariablesHash();

            if (this.hasAsset(assetName)) {
                this.removeAsset(this.findAssetByName(assetName));
            }

            request = _localization == null ? new URLRequest(assetName) :
                    new URLRequest(_localization.getExternalVariablesUrl() + "/" + _localization.getExternalVariablesHash());

            assetLoader = this.loadAssetFromFile(assetName, request, "text/plain");
            assetLoader.addEventListener("AssetLoaderEventComplete", onInitConfiguration);
            assetLoader.addEventListener("AssetLoaderEventError", onConfigurationError);
        }

        private function parseConfiguration(config: String): void {
            const lineBreakPattern: RegExp = /\n\r{1,}|\n{1,}|\r{1,}/gm;
            const trimPattern: RegExp = /^\s+|\s+$/g;
            const lines: Array = config.split(lineBreakPattern);
            var isReadOnly: Boolean = false;

            for each (var line: String in lines) {
                if (!(line.substr(0, 1) == "#" || line == "")) {
                    var parts: Array = line.split("=");
                    if (parts.length >= 2 && parts[0].length > 0 && parts[1].length > 0) {
                        var key: String = parts.shift().replace(trimPattern, "");
                        var value: String = parts.join("=").replace(trimPattern, "");
                        if (key == "configuration.readonly" && value == "true") {
                            isReadOnly = true;
                        }
                        setProperty(key, value, isReadOnly);
                    }
                }
            }
        }

        private function initEmbeddedConfigurations(): void {
            var environment: String = CommunicationUtils.readSOLString("environment");
            class_14.log("[HabboConfigurationManager] Default Environment: " + environment);

            for (var key in configurationData) {
                var index: int = key.lastIndexOf("." + environment);
                if (index != -1 && index + 1 + environment.length == key.length) {
                    var baseKey: String = key.substring(0, index);
                    var value: String = getProperty(key);
                    setProperty(baseKey, value);
                }
            }
        }

        private function fillParams(template: String, params: Dictionary): String {
            for (var i: int = 0; i < 10; i++) {
                var startIndex: int = template.indexOf(REPLACE_CHAR);
                if (startIndex < 0) {
                    break;
                }

                var endIndex: int = template.indexOf(REPLACE_CHAR, startIndex + 1);
                if (endIndex < 0) {
                    break;
                }

                var paramKey: String = template.substring(startIndex + 1, endIndex);
                var paramValue: String = String(params[paramKey]);
                template = template.replace(REPLACE_CHAR + paramKey + REPLACE_CHAR, paramValue);
            }
            return template;
        }

        private function onConfigurationError(event: Event = null): void {
            var assetLoaderEvent: AssetLoaderEvent = event as AssetLoaderEvent;
            var statusCode: int = 0;

            if (assetLoaderEvent != null) {
                statusCode = assetLoaderEvent.status;
            }

            class_14.log(assetLoaderEvent.toString());
            HabboWebTools.logEventLog("external_variables download error " + statusCode);
            class_79.error("Could not load external variables. Failed to load URL " + getProperty("external.variables.txt") + " HTTP status " + statusCode + ". Client startup failed!", true, 20);
        }

        private function onInitConfiguration(event: Event = null): void {
            if (disposed) {
                return;
            }

            var assetLoader: AssetLoaderStruct = event.target as AssetLoaderStruct;
            if (assetLoader == null) {
                return;
            }

            var configData: String;
            if (assetLoader.assetLoader.content is ByteArray) {
                var byteArray: ByteArray = assetLoader.assetLoader.content as ByteArray;
                byteArray.position = 0;
                configData = byteArray.readUTFBytes(byteArray.length);
            } else {
                configData = assetLoader.assetLoader.content as String;
            }

            if (configData != null) {
                parseConfiguration(configData);
            }

            var asset: IAsset = this.findAssetByName(assetLoader.assetName);
            if (asset != null) {
                this.removeAsset(asset).dispose();
            }

            if (configData == null || configData.length == 0) {
                var dataLength: int = configData != null ? configData.length : -1;
                class_79.error("Could not load external variables, got empty data from URL " + getProperty("external.variables.txt") + " data length = " + dataLength + ". Client startup failed!", false, 20);
            }

            if (!isConfigLoaded) {
                configurationsLoaded();
            }
        }

        private function configurationsLoaded(): void {
            events.dispatchEvent(new Event("HCE_CONFIGURATION_LOADED"));
            configurationsComplete();
        }

        private function configurationsComplete(): void {
            if (disposed || isConfigLoaded) {
                return;
            }
            isConfigLoaded = true;
            if (locked) {
                unlock();
            }
            events.dispatchEvent(new Event("complete"));
        }

        private function setDefaults(): void {
            ErrorReportStorage.addDebugData("Flashvars/host", "Host: " + getProperty("connection.info.host"));
            ErrorReportStorage.addDebugData("Flashvars/port", "Port: " + getProperty("connection.info.port"));
            setProperty("client.fatal.error.url", "${url.prefix}/flash_client_error");
            setProperty("game.center.error.url", "${url.prefix}/log/gameerror");

            var crossDomainPolicyFiles: String = getProperty("flashclient.crossdomain.policy.files");
            if (crossDomainPolicyFiles && crossDomainPolicyFiles != "") {
                var policyFiles: Array = crossDomainPolicyFiles.split(",");
                for each (var policyFile: String in policyFiles) {
                    policyFile = policyFile.replace(" ", "");
                    Security.loadPolicyFile(policyFile);
                }
            }
        }

        private function parseDevelopmentVariables(): void {
            // Implementation for parsing development variables
        }

        private function parseCommonVariables(): void {
            parseConfigurationAsset("common_configuration");
        }

        private function parseConfigurationAsset(assetName: String): void {
            var asset: TextAsset = this.findAssetByName(assetName) as TextAsset;
            if (asset != null) {
                parseConfiguration(asset.content.toString());
            } else {
                class_14.log("Could not parse configuration " + assetName);
            }
        }

        private function parseLocalizationVariables(): void {
            parseConfigurationAsset("localization_configuration");
        }

        private function parseArguments(): void {
            var core: ICore = context as ICore;
            var args: Dictionary = core.arguments;
            for (var key: String in args) {
                var value: String = String(args[key]);
                key = key.replace(/[_]/g, ".");
                setProperty(key, value);
                if (environmentId == null && key == "environment.id") {
                    environmentId = value;
                }
            }
            core.clearArguments();
        }
    }
}