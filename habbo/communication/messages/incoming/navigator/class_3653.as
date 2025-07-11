package com.sulake.habbo.communication.messages.incoming.navigator {
    [SecureSWF(rename="true")]
    public class class_3653 {

        public static const const_165: int = 0;

        public static const const_265: int = 1;

        public static const const_282: int = 2;

        public static const const_124: int = 3;

        public static const const_98: int = 4;

        public function class_3653() {
            super();
        }
        private var var_4553: Boolean;
        private var var_1194: int;
        private var var_280: int;
        private var var_329: String;
        private var var_363: String;
        private var var_4451: Boolean;
        private var var_4768: Boolean;
        private var var_4702: Boolean;
        private var var_937: String;

        private var _ownerName: String;

        public function get ownerName(): String {
            return _ownerName;
        }

        public function set ownerName(param1: String): void {
            _ownerName = param1;
        }

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        public function set name(param1: String): void {
            _name = param1;
        }

        public function get allowFurniMoving(): Boolean {
            return var_4553;
        }

        public function set allowFurniMoving(param1: Boolean): void {
            var_4553 = param1;
        }

        public function get doorMode(): int {
            return var_1194;
        }

        public function set doorMode(param1: int): void {
            var_1194 = param1;
        }

        public function get id(): int {
            return var_280;
        }

        public function set id(param1: int): void {
            var_280 = param1;
        }

        public function get type(): String {
            return var_329;
        }

        public function set type(param1: String): void {
            var_329 = param1;
        }

        public function get description(): String {
            return var_363;
        }

        public function set description(param1: String): void {
            var_363 = param1;
        }

        public function get showOwnerName(): Boolean {
            return var_4451;
        }

        public function set showOwnerName(param1: Boolean): void {
            var_4451 = param1;
        }

        public function get allowTrading(): Boolean {
            return var_4768;
        }

        public function set allowTrading(param1: Boolean): void {
            var_4768 = param1;
        }

        public function get categoryAlertKey(): Boolean {
            return var_4702;
        }

        public function set categoryAlertKey(param1: Boolean): void {
            var_4702 = param1;
        }

        public function get password(): String {
            return var_937;
        }

        public function set password(param1: String): void {
            var_937 = param1;
        }
    }
}
