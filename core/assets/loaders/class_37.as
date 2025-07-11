package com.sulake.core.assets.loaders {
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.events.EventDispatcherWrapper;

    import flash.events.Event;
    import flash.events.HTTPStatusEvent;

    internal class class_37 extends EventDispatcherWrapper implements IDisposable {

        public static const NONE: uint = 0;

        public static const IO_ERROR: uint = 1;

        public static const const_113: uint = 2;

        protected var _status: int = 0;

        protected var var_51: int = 0;

        protected var var_1413: int = 2;

        protected var var_412: uint = 0;

        public function class_37() {
            super();
        }

        public function get errorCode(): uint {
            return var_412;
        }

        protected function loadEventHandler(param1: Event): void {
            switch (param1.type) {
                case "httpStatus":
                    _status = HTTPStatusEvent(param1).status;
                    dispatchEvent(new AssetLoaderEvent("AssetLoaderEventStatus", _status));
                    break;
                case "complete":
                    dispatchEvent(new AssetLoaderEvent("AssetLoaderEventComplete", _status));
                    break;
                case "unload":
                    dispatchEvent(new AssetLoaderEvent("AssetLoaderEventUnload", _status));
                    break;
                case "open":
                    dispatchEvent(new AssetLoaderEvent("AssetLoaderEventOpen", _status));
                    break;
                case "progress":
                    dispatchEvent(new AssetLoaderEvent("AssetLoaderEventProgress", _status));
                    break;
                case "ioError":
                    var_412 = 1;
                    if (!retry()) {
                        dispatchEvent(new AssetLoaderEvent("AssetLoaderEventError", _status));
                    }
                    break;
                case "securityError":
                    var_412 = 2;
                    if (!retry()) {
                        dispatchEvent(new AssetLoaderEvent("AssetLoaderEventError", _status));
                    }
            }
        }

        protected function retry(): Boolean {
            return false;
        }
    }
}
