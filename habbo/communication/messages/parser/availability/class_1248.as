package com.sulake.habbo.communication.messages.parser.availability {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1248 implements IMessageParser {

        public function class_1248() {
            super();
        }
        private var var_498: int;
        private var var_585: int;
        private var var_429: Boolean;

        public function get openHour(): int {
            return var_498;
        }

        public function get openMinute(): int {
            return var_585;
        }

        public function get userThrownOutAtClose(): Boolean {
            return var_429;
        }

        public function flush(): Boolean {
            var_498 = 0;
            var_585 = 0;
            var_429 = false;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_498 = param1.readInteger();
            var_585 = param1.readInteger();
            var_429 = param1.readBoolean();
            return true;
        }
    }
}
