package com.sulake.core.runtime {
    import com.sulake.core.assets.AssetLibrary
    import com.sulake.core.assets.IAssetLibrary
    import com.sulake.core.runtime.events.ErrorEvent
    import com.sulake.core.runtime.events.ILinkEventTracker
    import com.sulake.core.runtime.events.LockEvent
    import com.sulake.core.runtime.events.WarningEvent
    import com.sulake.core.runtime.exceptions.InvalidComponentException
    import com.sulake.core.utils.LibraryLoader
    import com.sulake.core.utils.class_43

    import flash.display.DisplayObjectContainer
    import flash.display.Sprite
    import flash.events.Event
    import flash.net.URLRequest
    import flash.system.ApplicationDomain
    import flash.system.LoaderContext
    import flash.utils.ByteArray
    import flash.utils.getDefinitionByName
    import flash.utils.getQualifiedClassName

    [SecureSWF(rename="true")]
    public class ComponentContext extends Component implements IContext {

        private var _linkEventTrackers: Vector.<ILinkEventTracker>;

        protected var _attachedComponents: Vector.<Component>;

        protected var _interfacesQueued: Vector.<ComponentInterfaceQueue>;

        protected var _loaders: Vector.<LibraryLoader>;

        protected var var_154: Boolean = true;

        protected var _displayObjectContainer: DisplayObjectContainer;

        private var _configuration: ICoreConfiguration;

        public function ComponentContext(param1: IContext, param2: uint = 0, param3: IAssetLibrary = null) {
            _displayObjectContainer = new Sprite();
            _attachedComponents = new Vector.<Component>();
            _interfacesQueued = new Vector.<ComponentInterfaceQueue>();
            _linkEventTrackers = new Vector.<ILinkEventTracker>(0);
            super(param1, param2 | 2, param3);
        }

        public function get root(): IContext {
            if (!context || context == this) {
                return this;
            }
            return context.root;
        }

        public function get displayObjectContainer(): DisplayObjectContainer {
            return _displayObjectContainer;
        }

        override public function purge(): void {
            super.purge();
            for each(var _loc1_: Component in _attachedComponents) {
                if (_loc1_ != this) {
                    _loc1_.purge();
                }
            }
        }

        public function debug(param1: String): void {
            _lastDebugMessage = param1;
            if (var_154 && events) {
                events.dispatchEvent(new Event("COMPONENT_EVENT_DEBUG"));
            }
        }

        public function getLastDebugMessage(): String {
            return _lastDebugMessage;
        }

        public function warning(param1: String): void {
            _lastWarningMessage = param1;
            if (events != null) {
                events.dispatchEvent(new WarningEvent("COMPONENT_EVENT_WARNING", param1));
            }
        }

        public function getLastWarningMessage(): String {
            return _lastWarningMessage;
        }

        public function error(param1: String, param2: Boolean, param3: int = -1, param4: Error = null): void {
            _lastError = param1;
            trace("Error: ", param1, param2, param3, param4);
            if (events != null) {
                events.dispatchEvent(new ErrorEvent("COMPONENT_EVENT_ERROR", param1, param2, param3, param4));
            }
        }

        public function getLastErrorMessage(): String {
            return _lastError;
        }

        final public function loadFromFile(param1: URLRequest, param2: LoaderContext): LibraryLoader {
            var _loc3_: LibraryLoader = null;
            if (_loaders == null) {
                _loaders = new Vector.<LibraryLoader>();
            }
            for each(_loc3_ in _loaders) {
                if (_loc3_.url == param1.url) {
                    return _loc3_;
                }
            }
            _loc3_ = new LibraryLoader(param2, var_154);
            _loc3_.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE", loadReadyHandler, false);
            _loc3_.addEventListener("LIBRARY_LOADER_EVENT_ERROR", loadErrorHandler, false);
            _loc3_.addEventListener("LIBRARY_LOADER_EVENT_DEBUG", loadDebugHandler, false);
            _loc3_.load(param1);
            _loaders.push(_loc3_);
            return _loc3_;
        }

        final protected function loadReadyHandler(param1: class_43): void {
            var _loc2_: LibraryLoader = param1.target as LibraryLoader;
            removeLibraryLoader(_loc2_);
            prepareComponent(_loc2_.resource, 0, _loc2_.domain);
        }

        protected function loadErrorHandler(param1: class_43): void {
            var _loc2_: LibraryLoader = null;
            _loc2_ = param1.target as LibraryLoader;
            var _loc3_: String = _loc2_.getLastErrorMessage();
            removeLibraryLoader(_loc2_);
            error("Failed to download component resource \"" + _loc2_.url + "\"!" + "\r" + _loc3_, true, 5);
        }

        protected function loadDebugHandler(param1: class_43): void {
            var _loc2_: LibraryLoader = null;
            _loc2_ = param1.target as LibraryLoader;
            var _loc3_: String = _loc2_.getLastDebugMessage();
            debug(_loc3_);
        }

        protected function removeLibraryLoader(param1: LibraryLoader): void {
            param1.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE", loadReadyHandler, false);
            param1.removeEventListener("LIBRARY_LOADER_EVENT_ERROR", loadReadyHandler, false);
            param1.dispose();
            var _loc2_: int = _loaders.indexOf(param1);
            if (_loc2_ > -1) {
                _loaders.splice(_loc2_, 1);
            }
        }

        public function prepareAssetLibrary(param1: XML, param2: Class): Boolean {
            return assets.loadFromResource(param1, param2);
        }

        final public function prepareComponent(componentClass: Class, flags: uint = 0, applicationDomain: ApplicationDomain = null): IUnknown {
            var manifestXml: XML = null;
            var manifestData: Object = null;
            var manifestBytes: ByteArray = null;
            var componentDefinition: Class = null;
            var componentClassName: String = null;
            var assetsList: XMLList = null;
            var componentInstance: Component = null;
            var interfaceIds: Array = null;
            var interfaceDefinition: Class = null;
            var interfaceName: String = null;
            var interfaceId: IID = null;
            var interfaceStructList: InterfaceStructList;
            var assetLibrary: IAssetLibrary = null;

            if (applicationDomain == null) {
                applicationDomain = ApplicationDomain.currentDomain;
            }

            try {
                manifestData = (componentClass as Object).manifest;
                if (manifestData is XML) {
                    manifestXml = manifestData as XML;
                } else if (manifestData is Class) {
                    manifestBytes = new (manifestData as Class)() as ByteArray;
                    manifestXml = new XML(manifestBytes.readUTFBytes(manifestBytes.length));
                }
            } catch (error: Error) {
                manifestXml = null;
            }

            if (manifestXml == null) {
                return null;
            }

            var componentList: XMLList = manifestXml.child("component");
            for (var i: int = 0; i < componentList.length(); i++) {
                var componentXml: XML = componentList[i];
                var componentVersion: String = componentXml.attribute("version");
                componentClassName = componentXml.attribute("class");
                assetsList = componentXml.child("assets");

                if (assetsList.length() > 0) {
                    var manifest: XML = <manifest>
                        <library/>
                    </manifest>;
                    manifest.library.appendChild(assetsList);
                    manifest.library.appendChild(componentXml.child("aliases"));
                    assetLibrary = new AssetLibrary("_assets@" + componentClassName, manifest);
                    assetLibrary.loadFromResource(manifest, componentClass);
                }

                try {
                    componentDefinition = applicationDomain.getDefinition(componentClassName) as Class;
                } catch (e: ReferenceError) {
                    try {
                        componentDefinition = getDefinitionByName(componentClassName) as Class;
                    } catch (e: ReferenceError) {
                        error("Invalid component class " + componentClassName + "!", true, 4);
                        return null;
                    }
                }

                if (componentDefinition == null) {
                    error("Invalid component class " + componentClassName + "!", true, 4);
                    return null;
                }

                componentInstance = assetLibrary == null ? new componentDefinition(this, flags) : new componentDefinition(this, flags, assetLibrary);
                if (componentInstance != null) {
                    if (assetLibrary != null && componentInstance.assets != assetLibrary) {
                        assetLibrary.dispose();
                        error("Component \"" + componentClassName + "\" did not save provided asset library!", true, 4);
                    }

                    var interfaceList: XMLList = componentXml.child("interface");
                    interfaceIds = [];
                    for each (var interfaceXml: XML in interfaceList) {
                        interfaceName = String(interfaceXml.attribute("iid"));
                        try {
                            interfaceDefinition = applicationDomain.getDefinition(interfaceName) as Class;
                        } catch (e: ReferenceError) {
                            try {
                                interfaceDefinition = getDefinitionByName(interfaceName) as Class;
                            } catch (e: ReferenceError) {
                                throw new InvalidComponentException("Identifier class defined in manifest not found: " + interfaceName);
                            }
                        }

                        interfaceId = new interfaceDefinition();
                        interfaceStructList = getInterfaceStructList(componentInstance);
                        interfaceStructList.insert(new InterfaceStruct(interfaceId, componentInstance));
                        interfaceIds.push(interfaceId);
                    }

                    attachComponent(componentInstance, interfaceIds);
                }
            }

            return componentInstance as IUnknown;
        }

        final public function attachComponent(component: Component, interfaces: Array): void {
            var interfaceId: IID = null;

            if (_attachedComponents == null) {
                return;
            }

            if (_attachedComponents.indexOf(component) > -1) {
                error("Component " + component + " already attached to context!", false);
                return;
            }

            _attachedComponents.push(component);

            if (component.locked) {
                component.events.addEventListener("_INTERNAL_EVENT_UNLOCKED", unlockEventHandler);
            }

            for each (interfaceId in interfaces) {
                if (getInterfaceStructList(component).find(interfaceId) == null) {
                    getInterfaceStructList(component).insert(new InterfaceStruct(interfaceId, component));
                }
                getInterfaceStructList(this).insert(new InterfaceStruct(interfaceId, component));
            }

            if (!component.locked) {
                for each (interfaceId in interfaces) {
                    if (hasQueueForInterface(interfaceId)) {
                        announceInterfaceAvailability(interfaceId, component);
                    }
                }
            }
        }

        final public function detachComponent(component: Component): void {
            var interfaceStruct: InterfaceStruct = null;
            var interfaceStructList: InterfaceStructList = getInterfaceStructList(this);
            var index: int = interfaceStructList.getIndexByImplementor(component);

            while (index > -1) {
                interfaceStruct = interfaceStructList.remove(index);
                index = interfaceStructList.getIndexByImplementor(component);
            }

            for (var i: int = 0; i < _attachedComponents.length; i++) {
                if (_attachedComponents[i] == component) {
                    _attachedComponents.splice(i, 1);
                    component.events.removeEventListener("_INTERNAL_EVENT_UNLOCKED", unlockEventHandler);
                    return;
                }
            }
        }

        override public function queueInterface(iid: IID, callback: Function = null): IUnknown {
            var result: IUnknown = null;
            var interfaceStructList: InterfaceStructList = getInterfaceStructList(this);

            if (interfaceStructList == null) {
                return null;
            }

            var interfaceStruct: InterfaceStruct = interfaceStructList.getStructByInterface(iid);

            if (interfaceStruct != null) {
                if (interfaceStruct.unknown == this && interfaceStruct.iis == getQualifiedClassName(iid)) {
                    return super.queueInterface(iid, callback);
                }
                result = interfaceStruct.unknown.queueInterface(iid, callback);
                if (result != null) {
                    return result;
                }
            }

            if (callback != null) {
                addQueueeForInterface(iid, callback);
                if (context && context != this) {
                    context.queueInterface(iid, announceInterfaceAvailability);
                }
            }

            return null;
        }

        final protected function addQueueeForInterface(iid: IID, callback: Function): void {
            var queue: ComponentInterfaceQueue;

            if (hasQueueForInterface(iid)) {
                queue = getQueueForInterface(iid);
            } else {
                queue = new ComponentInterfaceQueue(iid);
                _interfacesQueued.push(queue);
            }

            queue.receivers.unshift(callback);
        }

        final protected function hasQueueForInterface(iid: IID): Boolean {
            if (_interfacesQueued == null) {
                return false;
            }

            var iidClassName: String = getQualifiedClassName(iid);

            for each (var queue: ComponentInterfaceQueue in _interfacesQueued) {
                if (getQualifiedClassName(queue.identifier) == iidClassName) {
                    return true;
                }
            }

            return false;
        }

        final protected function getQueueForInterface(iid: IID): ComponentInterfaceQueue {
            var iidClassName: String = getQualifiedClassName(iid);

            for each (var queue: ComponentInterfaceQueue in _interfacesQueued) {
                if (getQualifiedClassName(queue.identifier) == iidClassName) {
                    return queue;
                }
            }

            return null;
        }

        final protected function announceInterfaceAvailability(iid: IID, component: Component): void {
            var interfaceQueue: ComponentInterfaceQueue = getQueueForInterface(iid);

            if (interfaceQueue == null) {
                return;
            }

            var numberOfReceivers: uint = interfaceQueue.receivers.length;

            for (var i: uint = 0; i < numberOfReceivers; i++) {
                var interfaceInstance: IUnknown = component.queueInterface(iid);

                if (interfaceInstance == null) {
                    error("Interface " + iid + " still unavailable!", true, 6);
                }

                if (interfaceQueue.receivers != null) {
                    interfaceQueue.receivers.pop()(iid, interfaceInstance);
                }
            }
        }

        override public function dispose(): void {
            var component: IUnknown;
            var loader: LibraryLoader;

            if (!disposed) {
                super.dispose();

                if (_attachedComponents != null) {
                    while (_attachedComponents.length > 0) {
                        component = IUnknown(_attachedComponents.pop());
                        component.dispose();
                    }
                    _attachedComponents = null;
                }

                if (_interfacesQueued != null) {
                    while (_interfacesQueued.length > 0) {
                        var queuedInterface: IDisposable = IDisposable(_interfacesQueued.pop());
                        queuedInterface.dispose();
                    }
                    _interfacesQueued = null;
                }

                if (_loaders != null) {
                    while (_loaders.length > 0) {
                        loader = _loaders[0];
                        removeLibraryLoader(loader);
                        loader.dispose();
                    }
                    _loaders = null;
                }
            }
        }

        private function unlockEventHandler(event: LockEvent): void {
            var interfaceStruct: InterfaceStruct;
            var structsByImplementor: Array;
            var component: Component = event.unknown as Component;

            if (!component.disposed) {
                component.events.removeEventListener("_INTERNAL_EVENT_UNLOCKED", unlockEventHandler);
            }

            if (!disposed) {
                structsByImplementor = [];
                getInterfaceStructList(this).mapStructsByImplementor(component, structsByImplementor);

                while (structsByImplementor.length && !component.disposed && !disposed) {
                    interfaceStruct = structsByImplementor.pop();
                    announceInterfaceAvailability(interfaceStruct.iid, component);
                }

                root.events.dispatchEvent(new Event("COMPONENT_EVENT_UNLOCKED"));
            }
        }

        override public function toXMLString(indentationLevel: uint = 0): String {
            var interfaceStruct: InterfaceStruct;
            var component: Component;
            var indentation: String = "";
            var className: String = getQualifiedClassName(this);
            var xmlString: String = "";
            var interfaceList: Array = [];
            var numInterfaces: uint;
            var numComponents: uint;

            // Create the indentation string
            for (var i: uint = 0; i < indentationLevel; i++) {
                indentation += "\t";
            }

            // Start the XML string
            xmlString += indentation + "<context class=\"" + className + "\" >\n";

            // Get the list of interfaces
            numInterfaces = getInterfaceStructList(this).mapStructsByImplementor(this, interfaceList);

            // Add interfaces to the XML string
            for (var j: uint = 0; j < numInterfaces; j++) {
                interfaceStruct = interfaceList[j];
                xmlString += indentation + "\t<interface iid=\"" + interfaceStruct.iis + "\" refs=\"" + interfaceStruct.references + "\"/>\n";
            }

            // Add attached components to the XML string
            numComponents = _attachedComponents.length;
            for (var k: uint = 0; k < numComponents; k++) {
                component = _attachedComponents[k] as Component;
                if (component != this) {
                    xmlString += component.toXMLString(indentationLevel + 1);
                }
            }

            // Close the XML string
            xmlString += indentation + "</context>\n";

            return xmlString;
        }

        public function set configuration(param1: ICoreConfiguration): void {
            _configuration = param1;
        }

        public function get configuration(): ICoreConfiguration {
            return _configuration;
        }

        public function addLinkEventTracker(param1: ILinkEventTracker): void {
            if (_linkEventTrackers.indexOf(param1) < 0) {
                _linkEventTrackers.push(param1);
            }
        }

        public function removeLinkEventTracker(param1: ILinkEventTracker): void {
            var _loc2_: int = _linkEventTrackers.indexOf(param1);
            if (_loc2_ > -1) {
                _linkEventTrackers.splice(_loc2_, 1);
            }
        }

        public function createLinkEvent(link: String): void {
            for each (var tracker: ILinkEventTracker in _linkEventTrackers) {
                if (tracker.linkPattern.length > 0) {
                    if (link.substr(0, tracker.linkPattern.length) == tracker.linkPattern) {
                        tracker.linkReceived(link);
                    }
                } else {
                    tracker.linkReceived(link);
                }
            }
        }

        public function get linkEventTrackers(): Vector.<ILinkEventTracker> {
            return _linkEventTrackers;
        }
    }
}
