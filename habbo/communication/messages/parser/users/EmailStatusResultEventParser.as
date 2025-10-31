package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class EmailStatusResultEventParser implements IMessageParser {

        public function EmailStatusResultEventParser() {
            super();
        }
        private var var_1251: String;
        private var var_1084: Boolean;
        private var var_1363: Boolean;

        public function get email(): String {
            return var_1251;
        }

        public function get isVerified(): Boolean {
            return var_1084;
        }

        public function get allowChange(): Boolean {
            return var_1363;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1251 = param1.readString();
            var_1084 = param1.readBoolean();
            var_1363 = param1.readBoolean();
            return true;
        }
    }
}
