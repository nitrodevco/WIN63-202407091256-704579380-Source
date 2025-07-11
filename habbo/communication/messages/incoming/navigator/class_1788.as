package com.sulake.habbo.communication.messages.incoming.navigator {
    [SecureSWF(rename="true")]
    public class class_1788 {

        public function class_1788() {
            super();
        }
        private var var_661: int;
        private var var_742: int;

        public function get pos(): int {
            return var_661;
        }

        public function set pos(param1: int): void {
            this.var_661 = param1;
        }

        public function get imgId(): int {
            return var_742;
        }

        public function set imgId(param1: int): void {
            this.var_742 = param1;
        }

        public function getCopy(): class_1788 {
            var _loc1_: class_1788 = new class_1788();
            _loc1_.var_661 = this.var_661;
            _loc1_.var_742 = this.var_742;
            return _loc1_;
        }
    }
}
