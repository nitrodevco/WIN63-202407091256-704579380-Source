package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class GuideTicketResolutionMessageEventParser implements IMessageParser {

        private static const const_104: int = 0;

        private static const const_292: int = 1;

        private static const const_152: int = 2;

        public function GuideTicketResolutionMessageEventParser() {
            super();
        }
        private var var_287: int = -1;

        public function get localizationCode(): String {
            if (var_287 == 0 || var_287 == 1) {
                return "valid";
            }
            return "invalid";
        }

        public function flush(): Boolean {
            var_287 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_287 = param1.readInteger();
            return true;
        }
    }
}
