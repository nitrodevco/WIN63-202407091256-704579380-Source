package com.sulake.habbo.communication.messages.parser.groupforums {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1755 extends class_1754 {

        public static function readFromMessage(param1: IMessageDataWrapper): class_1755 {
            var _loc2_: class_1755 = new class_1755();
            class_1754.fillFromMessage(_loc2_, param1);
            _loc2_.var_1559 = param1.readInteger();
            _loc2_.var_1542 = param1.readInteger();
            _loc2_.var_1526 = param1.readInteger();
            _loc2_.var_1554 = param1.readInteger();
            _loc2_.var_1095 = param1.readString();
            _loc2_.var_1137 = param1.readString();
            _loc2_.var_916 = param1.readString();
            _loc2_.var_767 = param1.readString();
            _loc2_.var_1566 = param1.readString();
            _loc2_.var_1515 = param1.readBoolean();
            _loc2_.var_1549 = param1.readBoolean();
            return _loc2_;
        }

        public function class_1755() {
            super();
        }
        private var var_1559: int;
        private var var_1542: int;
        private var var_1526: int;
        private var var_1554: int;
        private var var_1095: String;
        private var var_1137: String;
        private var var_916: String;
        private var var_767: String;
        private var var_1566: String;
        private var var_1515: Boolean;
        private var var_1549: Boolean;

        public function get readPermissions(): int {
            return var_1559;
        }

        public function get postMessagePermissions(): int {
            return var_1542;
        }

        public function get postThreadPermissions(): int {
            return var_1526;
        }

        public function get moderatePermissions(): int {
            return var_1554;
        }

        public function get canRead(): Boolean {
            return var_1095.length == 0;
        }

        public function get canReport(): Boolean {
            return true;
        }

        public function get canPostMessage(): Boolean {
            return var_1137.length == 0;
        }

        public function get canPostThread(): Boolean {
            return var_916.length == 0;
        }

        public function get canModerate(): Boolean {
            return var_767.length == 0;
        }

        public function get canChangeSettings(): Boolean {
            return var_1515;
        }

        public function get isStaff(): Boolean {
            return var_1549;
        }

        public function get readPermissionError(): String {
            return var_1095;
        }

        public function get postMessagePermissionError(): String {
            return var_1137;
        }

        public function get postThreadPermissionError(): String {
            return var_916;
        }

        public function get moderatePermissionError(): String {
            return var_767;
        }

        public function get reportPermissionError(): String {
            return var_1566;
        }
    }
}
