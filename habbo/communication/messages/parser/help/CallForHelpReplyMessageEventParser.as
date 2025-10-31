package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CallForHelpReplyMessageEventParser implements IMessageParser {

        public function CallForHelpReplyMessageEventParser() {
            super();
        }
        private var var_368: String;

        public function get message(): String {
            return var_368;
        }

        public function flush(): Boolean {
            var_368 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_368 = param1.readString();
            return true;
        }
    }
}
