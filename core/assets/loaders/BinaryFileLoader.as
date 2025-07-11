package com.sulake.core.assets.loaders {
   import com.sulake.core.utils.class_940

   import flash.events.Event
   import flash.events.SecurityErrorEvent
   import flash.events.TimerEvent
   import flash.net.URLLoader
   import flash.net.URLRequest
   import flash.utils.ByteArray
   import flash.utils.Timer

   public class BinaryFileLoader extends class_37 implements class_36 {

        protected var var_96: String;

        protected var var_329: String;

        protected var var_47: Object;

        protected var var_16: URLLoader;

        private var var_280: int;

        public function BinaryFileLoader(param1: String, param2: URLRequest = null, param3: int = -1) {
            super();
            var_96 = param2 == null ? "" : param2.url;
            var_329 = param1;
            var_16 = new URLLoader();
            var_16.dataFormat = "binary";
            var_16.addEventListener("complete", loadEventHandler);
            var_16.addEventListener("unload", loadEventHandler);
            var_16.addEventListener("httpStatus", loadEventHandler);
            var_16.addEventListener("progress", loadEventHandler);
            var_16.addEventListener("ioError", loadEventHandler);
            var_16.addEventListener("securityError", securityErrorEventHandler);
            var_280 = param3;
            if (param2 != null) {
                load(param2);
            }
        }

        public function get url(): String {
            return var_96;
        }

        public function get content(): Object {
            return !!var_47 ? var_47 : (!!var_16 ? var_16.data : null);
        }

        public function get bytes(): ByteArray {
            var _loc1_: ByteArray = null;
            if (var_16) {
                if (var_16.data is ByteArray) {
                    return var_16.data;
                }
                if (var_16.data is String) {
                    _loc1_ = new ByteArray();
                    _loc1_.writeUTFBytes(var_16.data);
                    return _loc1_;
                }
            }
            return null;
        }

        public function get mimeType(): String {
            return var_329;
        }

        public function get bytesLoaded(): uint {
            return !!var_16 ? var_16.bytesLoaded : 0;
        }

        public function get bytesTotal(): uint {
            return !!var_16 ? var_16.bytesTotal : 0;
        }

        public function get id(): int {
            return var_280;
        }

        public function load(param1: URLRequest): void {
            var _loc2_: Timer = null;
            var_96 = param1.url;
            var_47 = null;
            var_51 = 0;
            var_16.dataFormat = "binary";
            var_47 = class_940.method_20(param1.url) as String;
            if (var_47) {
                _loc2_ = new Timer(10, 1);
                _loc2_.addEventListener("timer", timerEventHandler);
                _loc2_.start();
                return;
            }
            var_16.load(param1);
        }

        override protected function retry(): Boolean {
            if (!_disposed) {
                if (++var_51 <= var_1413) {
                    try {
                        var_16.close();
                    } catch (e: Error) {
                    }
                    var_16.load(new URLRequest(var_96 + (var_96.indexOf("?") == -1 ? "?" : "&") + "retry=" + var_51));
                    return true;
                }
            }
            return false;
        }

        override public function dispose(): void {
            if (!_disposed) {
                super.dispose();
                var_16.removeEventListener("complete", loadEventHandler);
                var_16.removeEventListener("unload", loadEventHandler);
                var_16.removeEventListener("httpStatus", loadEventHandler);
                var_16.removeEventListener("progress", loadEventHandler);
                var_16.removeEventListener("ioError", loadEventHandler);
                var_16.removeEventListener("securityError", securityErrorEventHandler);
                try {
                    var_16.close();
                } catch (e: Error) {
                }
                var_16 = null;
                var_329 = null;
                var_47 = null;
                var_96 = null;
            }
        }

        private function securityErrorEventHandler(param1: SecurityErrorEvent): void {
            if (!_disposed) {
                loadEventHandler(param1);
            }
        }

        private function timerEventHandler(param1: TimerEvent): void {
            var _loc2_: Timer = param1.target as Timer;
            if (_loc2_) {
                _loc2_.stop();
                _loc2_.removeEventListener("timer", timerEventHandler);
            }
            if (!_disposed) {
                loadEventHandler(new Event("complete"));
            }
        }
    }
}
