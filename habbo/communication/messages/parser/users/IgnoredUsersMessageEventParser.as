package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class IgnoredUsersMessageEventParser implements IMessageParser {

        public function IgnoredUsersMessageEventParser() {
            super();
            var_333 = [];
        }
        protected var var_333: Array = null;

        public function get ignoredUsers(): Array {
            return var_333.slice();
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_333 = [];
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_333.push(param1.readInteger());
                _loc3_++;
            }
            return true;
        }
    }
}
