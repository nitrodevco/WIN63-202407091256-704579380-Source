package com.sulake.habbo.communication.messages.parser.room.engine {
    [SecureSWF(rename="true")]
    public class class_1655 {

        public function class_1655(param1: int, param2: Number, param3: Number) {
            super();
            var_771 = param1;
            var_822 = param2;
            _headDirection = param3;
        }
        private var var_771: int;
        private var var_822: Number;

        private var _headDirection: Number;

        public function get headDirection(): Number {
            return _headDirection;
        }

        public function get userIndex(): int {
            return var_771;
        }

        public function get bodyDirection(): Number {
            return var_822;
        }
    }
}
