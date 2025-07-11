package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1758 {

        public function class_1758(param1: IMessageDataWrapper) {
            super();
            var_1004 = param1.readInteger();
            var_1232 = param1.readInteger();
            var_1148 = param1.readInteger();
            var_1208 = param1.readString();
            var_1040 = param1.readString();
        }
        private var var_1004: int;
        private var var_1232: int;
        private var var_1148: int;
        private var var_1208: String;
        private var var_1040: String;

        public function get relationshipStatusType(): int {
            return var_1004;
        }

        public function get friendCount(): int {
            return var_1232;
        }

        public function get randomFriendId(): int {
            return var_1148;
        }

        public function get randomFriendName(): String {
            return var_1208;
        }

        public function get randomFriendFigure(): String {
            return var_1040;
        }
    }
}
