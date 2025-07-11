package com.sulake.habbo.communication {
    import com.hurlant.math.BigInteger
    import com.sulake.core.assets.IAssetLibrary
    import com.sulake.core.class_79
    import com.sulake.core.communication.ICoreCommunicationManager
    import com.sulake.core.communication.connection.IConnection
    import com.sulake.core.communication.connection.class_26
    import com.sulake.core.communication.encryption.IEncryption
    import com.sulake.core.communication.handshake.class_42
    import com.sulake.core.communication.messages.IMessageConfiguration
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.runtime.Component
    import com.sulake.core.runtime.ComponentDependency
    import com.sulake.core.runtime.IContext
    import com.sulake.core.utils.ErrorReportStorage
    import com.sulake.habbo.communication.encryption.ArcFour
    import com.sulake.habbo.communication.encryption.DiffieHellman
    import com.sulake.habbo.communication.messages.outgoing.handshake.DisconnectMessageComposer
    import com.sulake.iid.IIDCoreCommunicationManager
    import com.sulake.iid.IIDHabboConfigurationManager

    import flash.events.Event
    import flash.events.IOErrorEvent
    import flash.events.SecurityErrorEvent
    import flash.events.TimerEvent
    import flash.utils.Timer

    public class HabboCommunicationManager extends Component implements IHabboCommunicationManager, class_26 {

        private static const DEFAULT_CONNECTION_ATTEMPTS: int = 2;

        private var _communication: ICoreCommunicationManager;

        private var var_693: IMessageConfiguration;

        private var _host: String = "";

        private var _ports: Array;

        private var var_1265: Boolean = true;

        private var _portIndex: int = -1;

        private var var_743: Timer;

        private var var_140: int = 1;

        private var var_34: String = "";

        private var var_1277: Boolean = false;

        private var var_1125: Boolean = false;

        private var _a4: Array;

        private var var_361: Array;

        private var var_82: IHabboWebApiSession;

        private var var_26: IConnection;

        private var var_1263: int = 0;

        private var _requiresInitialRetryAttempt: Boolean = true;

        public function HabboCommunicationManager(param1: IContext, param2: uint = 0, param3: IAssetLibrary = null) {
            var_693 = new HabboMessages();
            _ports = [];
            var_743 = new Timer(100, 1);
            _a4 = [65191, 65178, 65178, 65177, 65185];
            var_361 = [];
            super(param1, param2, param3);
            param1.events.addEventListener("unload", unloading);
        }

        private static function getKeyValue(param1: Array, param2: int): String {
            var _loc5_: String = "";
            for each(var _loc3_ in param1) {
                for each(var _loc4_ in _loc3_) {
                    _loc5_ += String.fromCharCode(65290 - _loc4_ + param2--);
                }
            }
            return _loc5_;
        }

        override protected function get dependencies(): Vector.<ComponentDependency> {
            return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDCoreCommunicationManager(), function (param1: ICoreCommunicationManager): void {
                _communication = param1;
            }), new ComponentDependency(new IIDHabboConfigurationManager(), null, false, [{
                "type":"complete",
                "callback":onConfigurationComplete
            }])]);
        }

        private function onAuthenticated(param1: Event): void {
            var_26.isAuthenticated();
        }

        private function onConfigurationComplete(param1: Event): void {
            var_26.isConfigured();
        }

        public function disconnect(): void {
            if (var_26) {
                var_26.close();
            }
        }

        public function get connection(): IConnection {
            return var_26;
        }

        public function get mode(): int {
            return 0;
        }

        public function set mode(param1: int): void {
            var_1263 = param1;
        }

        public function get port(): int {
            if (_ports.length == 0 || _portIndex < 0 || _portIndex >= _ports.length) {
                return 0;
            }
            return _ports[_portIndex];
        }

        public function get suggestedLoginActions(): Array {
            return var_361;
        }

        public function set suggestedLoginActions(param1: Array): void {
            var_361 = param1;
        }

        override protected function initComponent(): void {
            try {
                context.events.addEventListener("HABBO_CONNECTION_EVENT_AUTHENTICATED", onAuthenticated);
                var_26 = _communication.createConnection(this);
                var_26.registerMessageClasses(var_693);
                var_26.addListener("ioError", onIOError);
                var_26.addListener("securityError", onSecurityError);
                var_26.addListener("connect", onConnect);
                updateHostParameters();
                if (var_1125) {
                    nextPort();
                }
            } catch (e: Error) {
                trace("Error creating connection: " + e.message);
                trace("Stack trace: " + e.getStackTrace());
            }
        }

        override public function dispose(): void {
            if (disposed) {
                return;
            }
            if (var_26) {
                var_26.dispose();
                var_26 = null;
            }
            if (var_82) {
                var_82.dispose();
                var_82 = null;
            }
            super.dispose();
        }

        public function updateHostParameters(): void {
            var _local_1: String = getProperty("connection.info.host", null);
            if (_local_1 == null) {
                class_79.crash("connection.info.host", 30);
                return;
            }
            ;

            var _local_2: String = getProperty("connection.info.port", null);
            if (_local_2 == null) {
                class_79.crash("connection.info.host", 30);
                return;
            }
            ;

            _ports = [];
            var _local_3: Array = _local_2.split(",");

            for each (var _local_4: String in _local_3) {
                _ports.push(parseInt(_local_4.replace(" ", "")));
            }
            ;

            _host = _local_1;
        }

        public function renewSocket(): void {
            var_140 = 1;
            _requiresInitialRetryAttempt = true;
            if (var_26 != null) {
                var_26.createSocket();
            }
        }

        public function initConnection(param1: String): void {
            var _loc2_: * = param1;
            if ("habbo" === _loc2_) {
                if (var_26 == null) {
                    class_79.crash("Tried to connect to proxy but connection was null", 30);
                    return;
                }
                var_1125 = true;
                if (allRequiredDependenciesInjected) {
                    nextPort();
                }
            }
        }

        public function addHabboConnectionMessageEvent(param1: IMessageEvent): IMessageEvent {
            if (var_26) {
                var_26.addMessageEvent(param1);
            }
            return param1;
        }

        public function removeHabboConnectionMessageEvent(param1: IMessageEvent): void {
            if (var_26) {
                var_26.removeMessageEvent(param1);
            }
        }

        public function connectionInit(param1: String, param2: int): void {
            ErrorReportStorage.setParameter("host", param1);
            ErrorReportStorage.setParameter("port", String(param2));
        }

        public function messageReceived(param1: String): void {
            ErrorReportStorage.setParameter("rece_msg_time", String(new Date().getTime()));
            if (var_34.length > 0) {
                var_34 += ",R:" + param1;
            } else {
                var_34 = "R:" + param1;
            }
            if (var_34.length > 150) {
                var_34 = var_34.substring(var_34.length - 150);
            }
        }

        public function messageSent(param1: String): void {
            ErrorReportStorage.setParameter("sent_msg_time", String(new Date().getTime()));
            if (var_34.length > 0) {
                var_34 += ",S:" + param1;
            } else {
                var_34 = "S:" + param1;
            }
            if (var_34.length > 150) {
                var_34 = var_34.substring(var_34.length - 150);
            }
        }

        public function messageParseError(param1: IMessageDataWrapper): void {
            ErrorReportStorage.setParameter("sent_msg_data", (param1 as Object).toString());
            ErrorReportStorage.addDebugData("MESSAGE_QUEUE", var_34);
        }

        public function setMessageQueueErrorDebugData(): void {
            ErrorReportStorage.addDebugData("MESSAGE_QUEUE", var_34);
        }

        public function initializeEncryption(): IEncryption {
            return new ArcFour();
        }

        public function set tcpNoDelay(param1: Boolean): void {
            var_1265 = param1;
        }

        public function initializeKeyExchange(param1: BigInteger, param2: BigInteger): class_42 {
            return new DiffieHellman(param1, param2);
        }

        private function nextPort(): void {
            var _loc1_: int = 0;
            if (!var_26) {
                return;
            }
            if (var_26.connected) {
                return;
            }
            _portIndex++;
            if (_portIndex >= _ports.length) {
                ErrorReportStorage.addDebugData("ConnectionRetry", "Connection attempt " + var_140);
                var_140++;
                _loc1_ = 2;
                if (_ports.length == 1) {
                    _loc1_++;
                }
                if (var_140 > _loc1_) {
                    if (var_1277) {
                        return;
                    }
                    var_1277 = true;
                    class_79.error("Connection failed to host and ports", true, 30);
                    return;
                }
                _portIndex = 0;
            }
            var_26.timeout = var_140 * 10000;
            var_26.init(getProperty("connection.info.host"), _ports[_portIndex], var_1265);
            if (_requiresInitialRetryAttempt) {
                _portIndex--;
                _requiresInitialRetryAttempt = false;
            }
        }

        private function tryNextPort(): void {
            var_743.addEventListener("timer", onTryNextPort);
            var_743.start();
        }

        private function unloading(param1: Event): void {
            if (var_26) {
                var_26.send(new DisconnectMessageComposer());
            }
        }

        private function onIOError(param1: IOErrorEvent): void {
            switch (param1.type) {
                case "ioError":
                case "diskError":
                case "networkError":
                case "verifyError":
            }
            ErrorReportStorage.addDebugData("Communication IO Error", "IOError " + param1.type + " on connect: " + param1.text + ". Port was " + _ports[_portIndex]);
            tryNextPort();
        }

        private function onConnect(param1: Event): void {
            ErrorReportStorage.addDebugData("Connection", "Connected with " + var_140 + " attempts");
        }

        private function onTryNextPort(param1: TimerEvent): void {
            nextPort();
        }

        private function onSecurityError(param1: SecurityErrorEvent): void {
            ErrorReportStorage.addDebugData("Communication Security Error", "SecurityError on connect: " + param1.text + ". Port was " + _ports[_portIndex]);
            tryNextPort();
        }

        public function createHabboWebApiSession(param1: IHabboWebApiListener, param2: String): IHabboWebApiSession {
            if (var_82 != null) {
                resetHabboWebApiSession();
            }
            var _loc3_: HabboWebApiSession = new HabboWebApiSession(param2);
            _loc3_.addListener(param1);
            var_82 = _loc3_;
            events.dispatchEvent(new Event("HABBO_POCKET_SESSION_CREATED"));
            return _loc3_;
        }

        public function getHabboWebApiSession(): IHabboWebApiSession {
            return var_82;
        }

        public function resetHabboWebApiSession(): void {
            if (var_82) {
                var_82.dispose();
                var_82 = null;
            }
        }
    }
}
