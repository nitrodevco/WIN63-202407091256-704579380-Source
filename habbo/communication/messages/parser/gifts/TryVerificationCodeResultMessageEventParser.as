package com.sulake.habbo.communication.messages.parser.gifts {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class TryVerificationCodeResultMessageEventParser implements IMessageParser {

        public function TryVerificationCodeResultMessageEventParser() {
            super();
        }
        private var var_296: int;
        private var var_383: int;

        public function get resultCode(): int {
            return var_296;
        }

        public function get millisecondsToAllowProcessReset(): int {
            return var_383;
        }

        public function flush(): Boolean {
            var_296 = -1;
            var_383 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_296 = param1.readInteger();
            var_383 = param1.readInteger();
            return true;
        }
    }
}
