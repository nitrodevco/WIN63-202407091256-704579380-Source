package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ChatReviewSessionStartedMessageEventParser implements IMessageParser {

        public function ChatReviewSessionStartedMessageEventParser() {
            super();
        }
        private var var_542: int;
        private var var_506: String;

        public function get votingTimeout(): int {
            return var_542;
        }

        public function get chatRecord(): String {
            return var_506;
        }

        public function flush(): Boolean {
            var_542 = -1;
            var_506 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_542 = param1.readInteger();
            var_506 = param1.readString();
            return true;
        }
    }
}
