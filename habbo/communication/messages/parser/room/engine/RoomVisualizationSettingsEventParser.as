package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class RoomVisualizationSettingsEventParser implements IMessageParser {

        public function RoomVisualizationSettingsEventParser() {
            super();
        }
        private var var_431: Boolean = false;
        private var var_336: Number = 1;
        private var var_224: Number = 1;

        public function get wallsHidden(): Boolean {
            return var_431;
        }

        public function get wallThicknessMultiplier(): Number {
            return var_336;
        }

        public function get floorThicknessMultiplier(): Number {
            return var_224;
        }

        public function flush(): Boolean {
            var_431 = false;
            var_336 = 1;
            var_224 = 1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_431 = param1.readBoolean();
            var _loc3_: int = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            if (_loc3_ < -2) {
                _loc3_ = -2;
            } else if (_loc3_ > 1) {
                _loc3_ = 1;
            }
            if (_loc2_ < -2) {
                _loc2_ = -2;
            } else if (_loc2_ > 1) {
                _loc2_ = 1;
            }
            var_336 = Math.pow(2, _loc3_);
            var_224 = Math.pow(2, _loc2_);
            return true;
        }
    }
}
