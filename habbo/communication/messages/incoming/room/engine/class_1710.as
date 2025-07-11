package com.sulake.habbo.communication.messages.incoming.room.engine {
    [SecureSWF(rename="true")]
    public class class_1710 {

        public function class_1710(param1: int, param2: int, param3: Boolean) {
            super();
            var_280 = param1;
            var_329 = param2;
            var_999 = param3;
        }
        private var var_280: int = 0;
        private var var_999: Boolean = false;
        private var var_1006: int = 0;
        private var var_1456: int = 0;
        private var var_1000: int = 0;
        private var var_862: int = 0;
        private var var_28: Number = 0;
        private var var_30: Number = 0;
        private var var_643: String = "";
        private var var_329: int = 0;
        private var var_149: int = 0;
        private var var_47: String = "";
        private var var_25: Boolean = false;
        private var var_1198: int = 0;
        private var var_876: int = 0;
        private var var_583: int;

        private var _ownerName: String = "";

        public function get ownerName(): String {
            return _ownerName;
        }

        public function set ownerName(param1: String): void {
            if (!var_25) {
                _ownerName = param1;
            }
        }

        public function get id(): int {
            return var_280;
        }

        public function get isOldFormat(): Boolean {
            return var_999;
        }

        public function get wallX(): Number {
            return var_1006;
        }

        public function set wallX(param1: Number): void {
            if (!var_25) {
                var_1006 = param1;
            }
        }

        public function get wallY(): Number {
            return var_1456;
        }

        public function set wallY(param1: Number): void {
            if (!var_25) {
                var_1456 = param1;
            }
        }

        public function get localX(): Number {
            return var_1000;
        }

        public function set localX(param1: Number): void {
            if (!var_25) {
                var_1000 = param1;
            }
        }

        public function get localY(): Number {
            return var_862;
        }

        public function set localY(param1: Number): void {
            if (!var_25) {
                var_862 = param1;
            }
        }

        public function get y(): Number {
            return var_28;
        }

        public function set y(param1: Number): void {
            if (!var_25) {
                var_28 = param1;
            }
        }

        public function get z(): Number {
            return var_30;
        }

        public function set z(param1: Number): void {
            if (!var_25) {
                var_30 = param1;
            }
        }

        public function get dir(): String {
            return var_643;
        }

        public function set dir(param1: String): void {
            if (!var_25) {
                var_643 = param1;
            }
        }

        public function get type(): int {
            return var_329;
        }

        public function set type(param1: int): void {
            if (!var_25) {
                var_329 = param1;
            }
        }

        public function get state(): int {
            return var_149;
        }

        public function set state(param1: int): void {
            if (!var_25) {
                var_149 = param1;
            }
        }

        public function get data(): String {
            return var_47;
        }

        public function set data(param1: String): void {
            if (!var_25) {
                var_47 = param1;
            }
        }

        public function get usagePolicy(): int {
            return var_1198;
        }

        public function set usagePolicy(param1: int): void {
            if (!var_25) {
                var_1198 = param1;
            }
        }

        public function get ownerId(): int {
            return var_876;
        }

        public function set ownerId(param1: int): void {
            if (!var_25) {
                var_876 = param1;
            }
        }

        public function get secondsToExpiration(): int {
            return var_583;
        }

        public function set secondsToExpiration(param1: int): void {
            if (!var_25) {
                var_583 = param1;
            }
        }

        public function setReadOnly(): void {
            var_25 = true;
        }
    }
}
