package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_1730

    [SecureSWF(rename="true")]
    public class RoomDimmerPresetsMessageEventParser implements IMessageParser {

        public function RoomDimmerPresetsMessageEventParser() {
            var_216 = [];
            super();
        }
        private var var_1136: int = 0;
        private var var_216: Array;
        private var var_517: int = 0;
        private var var_1149: Boolean = false;

        public function get itemId(): int {
            return var_517;
        }

        public function get presetCount(): int {
            return var_216.length;
        }

        public function get selectedPresetId(): int {
            return var_1136;
        }

        public function get isOn(): Boolean {
            return var_1149;
        }

        public function getPreset(param1: int): class_1730 {
            if (param1 < 0 || param1 >= presetCount) {
                return null;
            }
            return var_216[param1];
        }

        public function flush(): Boolean {
            var_216 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc5_: int = 0;
            var _loc7_: int = 0;
            var _loc9_: int = 0;
            var _loc6_: String = null;
            var _loc2_: int = 0;
            var _loc3_: int = 0;
            var _loc8_: class_1730 = null;
            var _loc4_: int = param1.readInteger();
            var_1136 = param1.readInteger();
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                _loc7_ = param1.readInteger();
                _loc9_ = param1.readInteger();
                _loc6_ = param1.readString();
                _loc2_ = parseInt(_loc6_.substr(1), 16);
                _loc3_ = param1.readInteger();
                (_loc8_ = new class_1730(_loc7_)).type = _loc9_;
                _loc8_.color = _loc2_;
                _loc8_.light = _loc3_;
                _loc8_.setReadOnly();
                var_216.push(_loc8_);
                _loc5_++;
            }
            var_1149 = param1.readBoolean();
            var_517 = param1.readInteger();
            return true;
        }
    }
}
