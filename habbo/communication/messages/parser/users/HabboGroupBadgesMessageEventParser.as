package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class HabboGroupBadgesMessageEventParser implements IMessageParser {

        public function HabboGroupBadgesMessageEventParser() {
            super();
        }
        protected var var_121: Map;

        public function get badges(): Map {
            var _loc1_: int = 0;
            var _loc2_: Map = new Map();
            _loc1_ = 0;
            while (_loc1_ < var_121.length) {
                _loc2_.add(var_121.getKey(_loc1_), var_121.getWithIndex(_loc1_));
                _loc1_++;
            }
            return _loc2_;
        }

        public function flush(): Boolean {
            if (var_121) {
                var_121.dispose();
                var_121 = null;
            }
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: String = null;
            var _loc5_: int = 0;
            var _loc4_: int = param1.readInteger();
            var_121 = new Map();
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                _loc3_ = param1.readInteger();
                _loc2_ = param1.readString();
                var_121.add(_loc3_, _loc2_);
                _loc5_++;
            }
            return true;
        }
    }
}
