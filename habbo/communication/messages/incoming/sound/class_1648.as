package com.sulake.habbo.communication.messages.incoming.sound {
    [SecureSWF(rename="true")]
    public class class_1648 {

        public function class_1648(param1: int, param2: int, param3: String, param4: String) {
            super();
            var_606 = param1;
            var_835 = param2;
            _songName = param3;
            var_994 = param4;
        }
        protected var var_606: int;
        protected var var_835: int;
        protected var _songName: String;
        protected var var_994: String;
        private var var_1051: Number = 0;

        public function get id(): int {
            return var_606;
        }

        public function get length(): int {
            return var_835;
        }

        public function get name(): String {
            return _songName;
        }

        public function get creator(): String {
            return var_994;
        }

        public function get startPlayHeadPos(): Number {
            return var_1051;
        }

        public function set startPlayHeadPos(param1: Number): void {
            var_1051 = param1;
        }
    }
}
