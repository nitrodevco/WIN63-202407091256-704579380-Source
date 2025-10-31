package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class HandItemReceivedMessageEventParser implements IMessageParser {

        public function HandItemReceivedMessageEventParser() {
            super();
        }
        private var var_590: int = -1;
        private var var_613: int = 0;

        public function get giverUserId(): int {
            return var_590;
        }

        public function get handItemType(): int {
            return var_613;
        }

        public function flush(): Boolean {
            var_590 = -1;
            var_613 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_590 = param1.readInteger();
            var_613 = param1.readInteger();
            return true;
        }
    }
}
