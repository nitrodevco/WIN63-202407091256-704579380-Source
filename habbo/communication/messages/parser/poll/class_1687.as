package com.sulake.habbo.communication.messages.parser.poll {
    [SecureSWF(rename="true")]
    public class class_1687 {

        public function class_1687(param1: String, param2: String, param3: int) {
            super();
            _value = param1;
            var_424 = param2;
            var_555 = param3;
        }
        private var var_424: String;

        private var var_555: int;

        private var _value: String;

        public function get value(): String {
            return _value;
        }

        public function set value(param1: String): void {
            _value = param1;
        }

        public function get choiceText(): String {
            return var_424;
        }

        public function set choiceText(param1: String): void {
            var_424 = param1;
        }

        public function get choiceType(): int {
            return var_555;
        }

        public function set choiceType(param1: int): void {
            var_555 = param1;
        }
    }
}
