package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.users.class_1745

    [SecureSWF(rename="true")]
    public class class_1234 implements IMessageParser {

        public function class_1234() {
            var_354 = [];
            super();
        }
        private var var_354: Array;

        public function get guilds(): Array {
            return var_354;
        }

        public function flush(): Boolean {
            var_354 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_354.push(new class_1745(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
