package com.sulake.core.runtime {
    import com.sulake.core.assets.AssetLibrary;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import com.sulake.core.runtime.events.LockEvent;
    import com.sulake.core.runtime.exceptions.*;
    import com.sulake.core.utils.ClassUtils;
    import com.sulake.core.utils.LibraryLoader;
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.net.URLRequest;
    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;

    [SecureSWF(rename="true")]
    public class Component implements IUnknown, ICoreConfiguration {

        public static const COMPONENT_EVENT_RUNNING: String = "COMPONENT_EVENT_RUNNING";
        public static const COMPONENT_EVENT_DISPOSING: String = "COMPONENT_EVENT_DISPOSING";
        public static const COMPONENT_EVENT_WARNING: String = "COMPONENT_EVENT_WARNING";
        public static const COMPONENT_EVENT_ERROR: String = "COMPONENT_EVENT_ERROR";
        public static const COMPONENT_EVENT_DEBUG: String = "COMPONENT_EVENT_DEBUG";
        public static const COMPONENT_EVENT_UNLOCKED: String = "COMPONENT_EVENT_UNLOCKED";
        public static const COMPONENT_EVENT_REBOOT: String = "COMPONENT_EVENT_REBOOT";

        protected static const INTERNAL_EVENT_UNLOCKED: String = "_INTERNAL_EVENT_UNLOCKED";

        public static const COMPONENT_FLAG_NULL: uint = 0;
        public static const COMPONENT_FLAG_INTERFACE: uint = 1;
        public static const COMPONENT_FLAG_CONTEXT: uint = 2;
        public static const COMPONENT_FLAG_DISPOSABLE: uint = 4;

        protected var _flags: uint = 0;
        protected var _lastError: String = "";
        protected var _lastDebugMessage: String = "";
        protected var _lastWarningMessage: String = "";

        private var _assets: IAssetLibrary;
        private var _events: EventDispatcherWrapper;
        private var _referenceCount: uint;
        private var _interfaceStructList: InterfaceStructList;
        private var _context: IContext;
        private var _disposed: Boolean = false;
        private var _locked: Boolean = false;
        private var _requiredDependenciesCount: int = 1;
        private var _requiredDependencyIids: Vector.<String>;
        private var _cleanupFunctions: Vector.<Function>;

        public function Component(context: IContext, flags: uint = 0, assetLibrary: IAssetLibrary = null) {
            _cleanupFunctions = new Vector.<Function>(0);
            super();
            try {
                _referenceCount = flags;
                _interfaceStructList = new InterfaceStructList();
                _events = new EventDispatcherWrapper();
                _context = context;
                _assets = assetLibrary != null ? assetLibrary : new AssetLibrary("_internal_asset_library");

                if (_context == null) {
                    throw new InvalidComponentException("IContext not provided to Component's constructor!");
                }

                if (dependencies.length > 0) {
                    lock();
                }

                _requiredDependencyIids = new Vector.<String>(0);
                for each(var dependency in dependencies) {
                    if (dependency.isRequired) {
                        _requiredDependencyIids.push(ClassUtils.getSimpleQualifiedClassName(dependency.identifier));
                    }
                    injectDependency(dependency.identifier, dependency.dependencySetter, dependency.isRequired, dependency.eventListeners);
                }
                allDependenciesRequested();
            } catch (error: Error) {
                trace("Error in Component constructor: " + error.message);
                trace(error.getStackTrace());
            }
        }

        public static function getInterfaceStructList(component: Component): InterfaceStructList {
            return component._interfaceStructList;
        }

        public function get locked(): Boolean {
            return _locked;
        }

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function get context(): IContext {
            return _context;
        }

        public function get events(): IEventDispatcher {
            return _events;
        }

        public function findAssetByName(name: String): IAsset {
            return _assets.getAssetByName(name);
        }

        public function removeAsset(asset: IAsset): IAsset {
            return _assets.removeAsset(asset);
        }

        public function loadAssetFromFile(name: String, request: URLRequest, type: String = null, cacheVersion: int = -1): AssetLoaderStruct {
            return _assets.loadAssetFromFile(name, request, type, cacheVersion);
        }

        public function hasAsset(name: String): Boolean {
            return _assets.hasAsset(name);
        }

        public function assetLoadFromFile(loader: LibraryLoader, cache: Boolean = true): void {
            _assets.loadFromFile(loader, cache);
        }

        public function get assets(): IAssetLibrary {
            return _assets;
        }

        private function injectDependency(identifier: IID, dependencySetter: Function, isRequired: Boolean, eventListeners: Array): void {
            if (isRequired) {
                _requiredDependenciesCount++;
            }
            queueInterface(identifier, createQueueCallback(dependencySetter, isRequired, eventListeners, ClassUtils.getSimpleQualifiedClassName(this)));
        }

        private function createQueueCallback(dependencySetter: Function, isRequired: Boolean, eventListeners: Array, componentName: String): Function {
            return function (iid: IID, unknown: IUnknown): void {
                if (disposed) {
                    return;
                }
                if (dependencySetter != null) {
                    dependencySetter(unknown);
                }
                if (eventListeners != null) {
                    var eventDispatcher: IEventDispatcher = Component(unknown).events;
                    for each(var listener in eventListeners) {
                        eventDispatcher.addEventListener(listener.type, listener.callback);
                    }
                }
                _cleanupFunctions.push(createCleanupFunction(iid, unknown, dependencySetter, eventListeners));
                if (isRequired) {
                    allDependenciesRequested(ClassUtils.getSimpleQualifiedClassName(iid));
                }
            };
        }

        private function createCleanupFunction(iid: IID, unknown: IUnknown, dependencySetter: Function, eventListeners: Array): Function {
            return function (): void {
                if (eventListeners != null) {
                    var eventDispatcher: IEventDispatcher = Component(unknown).events;
                    if (eventDispatcher != null) {
                        for each(var listener in eventListeners) {
                            eventDispatcher.removeEventListener(listener.type, listener.callback);
                        }
                    }
                }
                if (dependencySetter != null) {
                    dependencySetter(null);
                }
                unknown.release(iid);
            };
        }

        private function allDependenciesRequested(iidName: String = ""): void {
            try {
                _requiredDependenciesCount--;
                if (iidName != "" && _requiredDependencyIids.indexOf(iidName) > -1) {
                    _requiredDependencyIids.splice(_requiredDependencyIids.indexOf(iidName), 1);
                }
                if (_requiredDependenciesCount == 0) {
                    initComponent();
                    unlock();
                }
            } catch (error: Error) {
                trace("Error in allDependenciesRequested: " + error.message);
                trace(error.getStackTrace());
            }
        }

        protected function get allRequiredDependenciesInjected(): Boolean {
            return _requiredDependenciesCount == 0;
        }

        protected function get dependencies(): Vector.<ComponentDependency> {
            return new Vector.<ComponentDependency>(0);
        }

        protected function initComponent(): void {
            // To be implemented in subclasses
        }

        public function queueInterface(identifier: IID, callback: Function = null): IUnknown {
            var interfaceStruct: InterfaceStruct = _interfaceStructList.getStructByInterface(identifier);
            if (interfaceStruct == null) {
                return _context.queueInterface(identifier, callback);
            }
            if (_disposed) {
                throw new ComponentDisposedException("Failed to queue interface through disposed Component \"" + ClassUtils.getSimpleQualifiedClassName(this) + "\"!");
            }
            if (_locked) {
                return null;
            }
            interfaceStruct.reserve();
            var unknown: IUnknown = interfaceStruct.unknown as IUnknown;
            if (callback != null) {
                callback(identifier, unknown);
            }
            return unknown;
        }

        public function release(identifier: IID): uint {
            if (_disposed) {
                return 0;
            }
            var interfaceStruct: InterfaceStruct = _interfaceStructList.getStructByInterface(identifier);
            if (interfaceStruct == null) {
                _lastError = "Attempting to release unknown interface:" + identifier + "!";


                trace("Error: ", identifier);
                throw new Error(_lastError);
            }
            var referenceCount: uint = interfaceStruct.release();
            if (_flags & COMPONENT_FLAG_DISPOSABLE) {
                if (referenceCount == 0) {
                    if (_interfaceStructList.getTotalReferenceCount() == 0) {
                        _context.detachComponent(this);
                        this.dispose();
                    }
                }
            }
            return referenceCount;
        }

        public function dispose(): void {
            if (!_disposed) {
                for each(var cleanupFunction in _cleanupFunctions) {
                    cleanupFunction();
                }
                _cleanupFunctions = null;
                _events.dispatchEvent(new Event(COMPONENT_EVENT_DISPOSING));
                _events = null;
                _interfaceStructList.dispose();
                _interfaceStructList = null;
                _assets.dispose();
                _assets = null;
                _context = null;
                _flags = 0;
                _disposed = true;
            }
        }

        public function purge(): void {
            // To be implemented in subclasses if needed
        }

        final protected function lock(): void {
            if (!_locked) {
                _locked = true;
            }

            trace("Component \"" + ClassUtils.getSimpleQualifiedClassName(this) + "\" locked.");
        }

        final protected function unlock(): void {
            if (_locked) {
                _locked = false;
                _events.dispatchEvent(new LockEvent("_INTERNAL_EVENT_UNLOCKED", this));

                trace("Component \"" + ClassUtils.getSimpleQualifiedClassName(this) + "\" unlocked.");
            }
        }

        public function toString(): String {
            return "[component " + ClassUtils.getSimpleQualifiedClassName(this) + " refs: " + _flags + "]";
        }

        public function toXMLString(indent: uint = 0): String {
            var xmlString: String = "";
            for (var i: uint = 0; i < indent; i++) {
                xmlString += "\t";
            }
            var componentName: String = getQualifiedClassName(this);
            var result: String = xmlString + "<component class=\"" + componentName + "\">\n";
            var interfaceCount: uint = _interfaceStructList.length;
            for (var j: uint = 0; j < interfaceCount; j++) {
                var interfaceStruct: InterfaceStruct = _interfaceStructList.getStructByIndex(j);
                result += xmlString + "\t<interface iid=\"" + interfaceStruct.iis + "\" refs=\"" + interfaceStruct.references + "\"/>\n";
            }
            return result + (xmlString + "</component>\n");
        }

        public function get requiredDependencyIids(): Vector.<String> {
            return _requiredDependencyIids;
        }

        public function registerUpdateReceiver(receiver: IUpdateReceiver, priority: uint): void {
            if (!_disposed) {
                _context.registerUpdateReceiver(receiver, priority);
            }
        }

        public function removeUpdateReceiver(receiver: IUpdateReceiver): void {
            if (!_disposed) {
                _context.removeUpdateReceiver(receiver);
            }
        }

        public function get flags(): uint {
            return _flags;
        }

        public function propertyExists(name: String): Boolean {
            return !!_context.configuration ? _context.configuration.propertyExists(name) : false;
        }

        public function getProperty(name: String, parameters: Dictionary = null): String {
            return !!_context.configuration ? _context.configuration.getProperty(name, parameters) : "";
        }

        public function setProperty(name: String, value: String, overwrite: Boolean = false, log: Boolean = false): void {
            if (_context.configuration) {
                _context.configuration.setProperty(name, value, overwrite, log);
            }
        }

        public function getBoolean(name: String): Boolean {
            return !!_context.configuration ? _context.configuration.getBoolean(name) : false;
        }

        public function getInteger(name: String, defaultValue: int): int {
            return !!_context.configuration ? _context.configuration.getInteger(name, defaultValue) : 0;
        }

        public function interpolate(name: String): String {
            return !!_context.configuration ? _context.configuration.interpolate(name) : "";
        }

        public function updateUrlProtocol(url: String): String {
            return !!_context.configuration ? _context.configuration.updateUrlProtocol(url) : "";
        }
    }
}
