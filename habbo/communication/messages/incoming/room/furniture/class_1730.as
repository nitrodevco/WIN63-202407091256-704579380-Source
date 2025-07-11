package com.sulake.habbo.communication.messages.incoming.room.furniture {
    [SecureSWF(rename="true")]
    public class class_1730 {

        public function class_1730(param1: int) {
            super();
            var_280 = param1;
        }
        private var var_280: int = 0;
        private var var_329: int = 0;
        private var var_1022: uint = 0;

        private var var_25: Boolean = false;

        private var _color: uint = 0;

        public function get color(): uint {
            return _color;
        }

        public function set color(param1: uint): void {
            if (!var_25) {
                _color = param1;
            }
        }

        public function get id(): int {
            return var_280;
        }

        public function get type(): int {
            return var_329;
        }

        public function set type(param1: int): void {
            if (!var_25) {
                var_329 = param1;
            }
        }

        public function get light(): int {
            return var_1022;
        }

        public function set light(param1: int): void {
            if (!var_25) {
                var_1022 = param1;
            }
        }

        public function setReadOnly(): void {
            var_25 = true;
        }
    }
}
