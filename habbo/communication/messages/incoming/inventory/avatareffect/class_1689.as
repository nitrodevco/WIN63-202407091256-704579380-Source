package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect {
    [SecureSWF(rename="true")]
    public class class_1689 {

        public function class_1689() {
            super();
        }
        private var var_329: int;
        private var var_622: int;
        private var var_377: int;
        private var var_941: int;
        private var var_1079: int;
        private var var_927: Boolean;

        public function get type(): int {
            return var_329;
        }

        public function set type(param1: int): void {
            var_329 = param1;
        }

        public function get subType(): int {
            return var_622;
        }

        public function set subType(param1: int): void {
            var_622 = param1;
        }

        public function get duration(): int {
            return var_377;
        }

        public function set duration(param1: int): void {
            var_377 = param1;
        }

        public function get inactiveEffectsInInventory(): int {
            return var_941;
        }

        public function set inactiveEffectsInInventory(param1: int): void {
            var_941 = param1;
        }

        public function get secondsLeftIfActive(): int {
            return var_1079;
        }

        public function set secondsLeftIfActive(param1: int): void {
            var_1079 = param1;
        }

        public function get isPermanent(): Boolean {
            return var_927;
        }

        public function set isPermanent(param1: Boolean): void {
            var_927 = param1;
        }
    }
}
