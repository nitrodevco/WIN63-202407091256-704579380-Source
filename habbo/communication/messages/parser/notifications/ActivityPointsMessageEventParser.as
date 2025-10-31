package com.sulake.habbo.communication.messages.parser.notifications {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    import flash.utils.Dictionary

    [SecureSWF(rename="true")]
    public class ActivityPointsMessageEventParser implements IMessageParser {

        public function ActivityPointsMessageEventParser() {
            super();
        }
        private var var_682: Dictionary;

        public function get points(): Dictionary {
            return var_682;
        }

        public function flush(): Boolean {
            var_682 = new Dictionary();
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc4_: int = 0;
            var _loc5_: int = 0;
            var _loc2_: int = 0;
            var _loc3_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc5_ = param1.readInteger();
                _loc2_ = param1.readInteger();
                var_682[_loc5_] = _loc2_;
                _loc4_++;
            }
            return true;
        }
    }
}
