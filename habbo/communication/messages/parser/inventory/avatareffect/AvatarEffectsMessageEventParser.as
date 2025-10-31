package com.sulake.habbo.communication.messages.parser.inventory.avatareffect {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.class_1689

    [SecureSWF(rename="true")]
    public class AvatarEffectsMessageEventParser implements IMessageParser {

        public function AvatarEffectsMessageEventParser() {
            super();
        }
        private var var_264: Array;

        public function get effects(): Array {
            return var_264;
        }

        public function flush(): Boolean {
            var_264 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc4_: int = 0;
            var _loc2_: class_1689 = null;
            var_264 = [];
            var _loc3_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc2_ = new class_1689();
                _loc2_.type = param1.readInteger();
                _loc2_.subType = param1.readInteger();
                _loc2_.duration = param1.readInteger();
                _loc2_.inactiveEffectsInInventory = param1.readInteger();
                _loc2_.secondsLeftIfActive = param1.readInteger();
                _loc2_.isPermanent = param1.readBoolean();
                var_264.push(_loc2_);
                _loc4_++;
            }
            return true;
        }
    }
}
