package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1341 implements IMessageParser {

        public function class_1341() {
            super();
        }
        private var var_47: IMessageDataWrapper;
        private var var_178: int;
        private var var_31: int;
        private var var_28: int;
        private var _value: int;
        private var var_716: int = 16384;
        private var var_1061: int = 16383;

        public function set stackingBlockedMaskBit(param1: int): void {
            var_716 = 1 << param1;
            var_1061 = var_716 - 1;
        }

        public function get x(): int {
            return var_31;
        }

        public function get y(): int {
            return var_28;
        }

        public function get tileHeight(): Number {
            return class_1412.decodeTileHeight(_value, var_1061);
        }

        public function get isStackingBlocked(): Boolean {
            return class_1412.decodeIsStackingBlocked(_value, var_716);
        }

        public function get isRoomTile(): Boolean {
            return class_1412.decodeIsRoomTile(_value);
        }

        public function next(): Boolean {
            if (var_178 == 0) {
                return false;
            }
            var_178--;
            var_31 = var_47.readByte();
            var_28 = var_47.readByte();
            _value = var_47.readShort();
            return true;
        }

        public function flush(): Boolean {
            var_178 = 0;
            var_47 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_47 = param1;
            var_178 = param1.readByte();
            return true;
        }
    }
}
