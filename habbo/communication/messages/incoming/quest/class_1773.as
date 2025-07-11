package com.sulake.habbo.communication.messages.incoming.quest {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1773 implements class_1772 {

        public function class_1773(param1: IMessageDataWrapper) {
            super();
            var_418 = param1.readInteger();
            _userName = param1.readString();
            var_426 = param1.readString();
            var_931 = param1.readInteger();
            var_1353 = param1.readInteger();
        }
        private var var_418: int;
        private var var_426: String;

        private var var_931: int;

        private var var_1353: int;

        private var _userName: String;

        public function get userName(): String {
            return _userName;
        }

        public function get userId(): int {
            return var_418;
        }

        public function get figure(): String {
            return var_426;
        }

        public function get rank(): int {
            return var_931;
        }

        public function get currentScore(): int {
            return var_1353;
        }
    }
}
