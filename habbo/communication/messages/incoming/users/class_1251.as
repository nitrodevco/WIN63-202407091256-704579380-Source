package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1251 {

        private static const const_315: int = 0;

        private static const const_128: int = 1;

        private static const const_72: int = 2;

        private static const const_83: int = 3;

        private static const const_209: int = 4;

        public function class_1251(param1: IMessageDataWrapper) {
            super();
            var_329 = param1.readInteger();
            var_418 = param1.readInteger();
            _userName = param1.readString();
            var_426 = param1.readString();
            var_1154 = param1.readString();
        }
        private var var_329: int;
        private var var_418: int;
        private var var_426: String;

        private var var_1154: String;

        private var _userName: String;

        public function get userName(): String {
            return _userName;
        }

        public function get userId(): int {
            return var_418;
        }

        public function get admin(): Boolean {
            return var_329 == 1;
        }

        public function get owner(): Boolean {
            return var_329 == 0;
        }

        public function get member(): Boolean {
            return var_329 != 3;
        }

        public function get blocked(): Boolean {
            return var_329 == 4;
        }

        public function get figure(): String {
            return var_426;
        }

        public function get memberSince(): String {
            return var_1154;
        }
    }
}
