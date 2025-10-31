package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class IssueCloseNotificationMessageEventParser implements IMessageParser {

        public function IssueCloseNotificationMessageEventParser() {
            super();
        }
        private var var_1504: int;
        private var var_639: String;

        public function get closeReason(): int {
            return var_1504;
        }

        public function get messageText(): String {
            return var_639;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1504 = param1.readInteger();
            var_639 = param1.readString();
            return true;
        }
    }
}
