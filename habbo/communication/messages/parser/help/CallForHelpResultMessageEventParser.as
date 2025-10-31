package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CallForHelpResultMessageEventParser implements IMessageParser {

        public function CallForHelpResultMessageEventParser() {
            super();
        }
        private var var_491: int;
        private var var_639: String;

        public function get resultType(): int {
            return var_491;
        }

        public function get messageText(): String {
            return var_639;
        }

        public function flush(): Boolean {
            var_491 = -1;
            var_639 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_491 = param1.readInteger();
            var_639 = param1.readString();
            return true;
        }
    }
}
