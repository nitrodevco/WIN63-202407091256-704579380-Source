package com.sulake.habbo.communication.messages.parser.perk {
    [SecureSWF(rename="true")]
    public class class_1694 {

        public function class_1694() {
            super();
        }
        private var var_1078: String;
        private var var_831: Boolean = false;
        private var var_1088: String = "";

        public function get code(): String {
            return var_1078;
        }

        public function set code(param1: String): void {
            var_1078 = param1;
        }

        public function get isAllowed(): Boolean {
            return var_831;
        }

        public function set isAllowed(param1: Boolean): void {
            var_831 = param1;
        }

        public function get errorMessage(): String {
            return var_1088;
        }

        public function set errorMessage(param1: String): void {
            var_1088 = param1;
        }
    }
}
