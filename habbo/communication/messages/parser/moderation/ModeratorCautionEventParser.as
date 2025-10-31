package com.sulake.habbo.communication.messages.parser.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ModeratorCautionEventParser implements IMessageParser {

        public function ModeratorCautionEventParser() {
            super();
        }
        private var var_368: String;
        private var var_96: String;

        public function get message(): String {
            return var_368;
        }

        public function get url(): String {
            return var_96;
        }

        public function flush(): Boolean {
            var_368 = "";
            var_96 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_368 = param1.readString();
            var_96 = param1.readString();
            return true;
        }
    }
}
