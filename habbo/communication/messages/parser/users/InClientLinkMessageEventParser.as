package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class InClientLinkMessageEventParser implements IMessageParser {

        public function InClientLinkMessageEventParser() {
            super();
        }
        private var var_445: String;

        public function get link(): String {
            return var_445;
        }

        public function flush(): Boolean {
            var_445 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_445 = param1.readString();
            return true;
        }
    }
}
