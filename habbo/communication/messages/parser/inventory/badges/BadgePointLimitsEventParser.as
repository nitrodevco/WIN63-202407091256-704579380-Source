package com.sulake.habbo.communication.messages.parser.inventory.badges {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class BadgePointLimitsEventParser implements IMessageParser {

        public function BadgePointLimitsEventParser() {
            super();
        }
        private var var_47: Array;

        public function get data(): Array {
            return var_47;
        }

        public function flush(): Boolean {
            var_47 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc5_: int = 0;
            var _loc6_: String = null;
            var _loc2_: int = 0;
            var _loc3_: int = 0;
            var _loc4_: int = param1.readInteger();
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                _loc6_ = param1.readString();
                _loc2_ = param1.readInteger();
                _loc3_ = 0;
                while (_loc3_ < _loc2_) {
                    var_47.push(new class_1647(_loc6_, param1));
                    _loc3_++;
                }
                _loc5_++;
            }
            return true;
        }
    }
}
