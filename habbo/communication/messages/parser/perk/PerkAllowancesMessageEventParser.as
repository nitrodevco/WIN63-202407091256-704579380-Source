package com.sulake.habbo.communication.messages.parser.perk {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class PerkAllowancesMessageEventParser implements IMessageParser {

        public function PerkAllowancesMessageEventParser() {
            super();
        }
        private var var_221: Vector.<class_1694>;

        public function flush(): Boolean {
            var_221 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc4_: class_1694 = null;
            var_221 = new Vector.<class_1694>();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                (_loc4_ = new class_1694()).code = param1.readString();
                _loc4_.errorMessage = param1.readString();
                _loc4_.isAllowed = param1.readBoolean();
                var_221.push(_loc4_);
                _loc3_++;
            }
            return true;
        }

        public function getPerks(): Vector.<class_1694> {
            return var_221;
        }

        public function isPerkAllowed(param1: String): Boolean {
            var _loc2_: class_1694 = getPerk(param1);
            return _loc2_ != null && _loc2_.isAllowed;
        }

        public function getPerk(param1: String): class_1694 {
            for each(var _loc2_ in var_221) {
                if (_loc2_.code == param1) {
                    return _loc2_;
                }
            }
            return null;
        }
    }
}
