package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1412 implements IMessageParser {

        public static function decodeTileHeight(param1: int, param2: int): Number {
            return param1 == -1 ? -1 : (param1 & param2) / 256;
        }

        public static function decodeIsStackingBlocked(param1: int, param2: int): Boolean {
            return Boolean(param1 & param2);
        }

        public static function decodeIsRoomTile(param1: int): Boolean {
            return param1 != -1;
        }

        public function class_1412() {
            super();
        }
        private var var_716: int = 16384;
        private var var_1061: int = 16383;
        private var var_47: Vector.<int>;
        private var var_46: int = 0;

        private var _width: int = 0;

        public function get width(): int {
            return _width;
        }

        public function set stackingBlockedMaskBit(param1: int): void {
            var_716 = 1 << param1;
            var_1061 = var_716 - 1;
        }

        public function get height(): int {
            return var_46;
        }

        public function decodeTileHeight(param1: int): Number {
            return class_1412.decodeTileHeight(param1, var_1061);
        }

        public function decodeIsStackingBlocked(param1: int): Boolean {
            return class_1412.decodeIsStackingBlocked(param1, var_716);
        }

        public function getTileHeight(param1: int, param2: int): Number {
            if (param1 < 0 || param1 >= _width || param2 < 0 || param2 >= var_46) {
                return -1;
            }
            return decodeTileHeight(var_47[param2 * _width + param1]);
        }

        public function getStackingBlocked(param1: int, param2: int): Boolean {
            if (param1 < 0 || param1 >= _width || param2 < 0 || param2 >= var_46) {
                return true;
            }
            return decodeIsStackingBlocked(var_47[param2 * _width + param1]);
        }

        public function isRoomTile(param1: int, param2: int): Boolean {
            if (param1 < 0 || param1 >= _width || param2 < 0 || param2 >= var_46) {
                return false;
            }
            return decodeIsRoomTile(var_47[param2 * _width + param1]);
        }

        public function flush(): Boolean {
            var_47 = null;
            _width = 0;
            var_46 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            if (param1 == null) {
                return false;
            }
            _width = param1.readInteger();
            var _loc3_: int = param1.readInteger();
            var_46 = _loc3_ / _width;
            var_47 = new Vector.<int>(_loc3_);
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                var_47[_loc2_] = param1.readShort();
                _loc2_++;
            }
            return true;
        }
    }
}
