package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class IgnoreResultMessageEventParser implements IMessageParser {

        public function IgnoreResultMessageEventParser() {
            super();
            var_152 = -1;
        }
        private var var_152: int;
        private var var_1507: int;

        public function get result(): int {
            return var_152;
        }

        public function get ignoredUserId(): int {
            return var_1507;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_152 = param1.readInteger();
            var_1507 = param1.readInteger();
            return true;
        }
    }
}
