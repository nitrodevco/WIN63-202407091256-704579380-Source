package com.sulake.core.utils {
    import com.sulake.core.runtime.IDisposable

    import flash.utils.Dictionary
    import flash.utils.Proxy
    import flash.utils.flash_proxy

    use namespace flash_proxy;

    [SecureSWF(rename="true")]
    public class Map extends Proxy implements IDisposable {

        private var _length: uint;

        private var var_41: Dictionary;

        private var var_20: Array;

        private var var_49: Array;

        public function Map() {
            super();
            _length = 0;
            var_41 = new Dictionary();
            var_20 = [];
            var_49 = [];
        }

        public function get length(): uint {
            return _length;
        }

        public function get disposed(): Boolean {
            return var_41 == null;
        }

        public function dispose(): void {
            var _loc1_: Object = null;
            if (var_41 != null) {
                for (_loc1_ in var_41) {
                    delete var_41[_loc1_];
                }
                var_41 = null;
            }
            _length = 0;
            var_20 = null;
            var_49 = null;
        }

        public function reset(): void {
            var _loc1_: Object = null;
            for (_loc1_ in var_41) {
                delete var_41[_loc1_];
            }
            _length = 0;
            var_20 = [];
            var_49 = [];
        }

        public function unshift(param1: *, param2: *): Boolean {
            if (var_41[param1] != null) {
                return false;
            }
            var_41[param1] = param2;
            var_20.unshift(param2);
            var_49.unshift(param1);
            _length++;
            return true;
        }

        public function add(param1: *, param2: *): Boolean {
            if (var_41[param1] != null) {
                return false;
            }
            var_41[param1] = param2;
            var_20[_length] = param2;
            var_49[_length] = param1;
            _length++;
            return true;
        }

        public function remove(param1: *): * {
            var _loc2_: Object = var_41[param1];
            if (_loc2_ == null) {
                return null;
            }
            var _loc3_: int = var_20.indexOf(_loc2_);
            if (_loc3_ >= 0) {
                var_20.splice(_loc3_, 1);
                var_49.splice(_loc3_, 1);
                _length--;
            }
            delete var_41[param1];
            return _loc2_;
        }

        public function getWithIndex(param1: int): * {
            if (param1 < 0 || param1 >= _length) {
                return null;
            }
            return var_20[param1];
        }

        public function getKey(param1: int): * {
            if (param1 < 0 || param1 >= _length) {
                return null;
            }
            return var_49[param1];
        }

        public function getKeys(): Array {
            return var_49.slice();
        }

        public function hasKey(param1: *): Boolean {
            return var_49.indexOf(param1) > -1;
        }

        public function getValue(param1: *): * {
            return var_41[param1];
        }

        public function getValues(): Array {
            return var_20.slice();
        }

        public function hasValue(param1: *): Boolean {
            return var_20.indexOf(param1) > -1;
        }

        public function indexOf(param1: *): int {
            return var_20.indexOf(param1);
        }

        public function concatenate(param1: Map): void {
            var _loc3_: * = undefined;
            var _loc2_: Array = param1.var_49;
            for each(_loc3_ in _loc2_) {
                add(_loc3_, param1[_loc3_]);
            }
        }

        public function clone(): Map {
            var _loc1_: Map = new Map();
            _loc1_.concatenate(this);
            return _loc1_;
        }

        override flash_proxy function getProperty(param1: *): * {
            if (param1 is QName) {
                param1 = QName(param1).localName;
            }
            return var_41[param1];
        }

        override flash_proxy function setProperty(param1: *, param2: *): void {
            if (param1 is QName) {
                param1 = QName(param1).localName;
            }
            var_41[param1] = param2;
            var _loc3_: int = var_49.indexOf(param1);
            if (_loc3_ == -1) {
                var_20[_length] = param2;
                var_49[_length] = param1;
                _length++;
            } else {
                var_20.splice(_loc3_, 1, param2);
            }
        }

        override flash_proxy function nextNameIndex(param1: int): int {
            return param1 < _length ? param1 + 1 : 0;
        }

        override flash_proxy function nextName(param1: int): String {
            return var_49[param1 - 1];
        }

        override flash_proxy function nextValue(param1: int): * {
            return var_20[param1 - 1];
        }

        override flash_proxy function callProperty(param1: *, ...rest): * {
            return param1.localName == "toString" ? "Map" : null;
        }
    }
}
