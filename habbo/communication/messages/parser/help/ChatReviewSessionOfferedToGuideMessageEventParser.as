package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ChatReviewSessionOfferedToGuideMessageEventParser implements IMessageParser {

        public function ChatReviewSessionOfferedToGuideMessageEventParser() {
            super();
        }
        private var var_575: int;

        public function get acceptanceTimeout(): int {
            return var_575;
        }

        public function flush(): Boolean {
            var_575 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_575 = param1.readInteger();
            return true;
        }
    }
}
