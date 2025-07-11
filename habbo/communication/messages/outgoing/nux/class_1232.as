package com.sulake.habbo.communication.messages.outgoing.nux {
    [SecureSWF(rename="true")]
    public class class_1232 {

        public function class_1232(param1: int, param2: int, param3: int) {
            super();
            var_1024 = param1;
            var_1075 = param2;
            var_1222 = param3;
        }
        private var var_1024: int;
        private var var_1075: int;
        private var var_1222: int;

        public function get dayIndex(): int {
            return var_1024;
        }

        public function get stepIndex(): int {
            return var_1075;
        }

        public function get giftIndex(): int {
            return var_1222;
        }
    }
}
