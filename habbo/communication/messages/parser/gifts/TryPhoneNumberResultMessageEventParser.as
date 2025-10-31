package com.sulake.habbo.communication.messages.parser.gifts {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class TryPhoneNumberResultMessageEventParser implements IMessageParser {

        public function TryPhoneNumberResultMessageEventParser() {
            super();
        }
        private var var_296: int;
        private var var_1269: int;

        public function get resultCode(): int {
            return var_296;
        }

        public function get millisToAllowProcessReset(): int {
            return var_1269;
        }

        public function flush(): Boolean {
            var_296 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_296 = param1.readInteger();
            var_1269 = param1.readInteger();
            return true;
        }
    }
}
