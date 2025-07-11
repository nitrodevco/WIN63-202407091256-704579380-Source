package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1745 {

        public function class_1745(param1: IMessageDataWrapper) {
            super();
            _groupId = param1.readInteger();
            _groupName = param1.readString();
            var_413 = param1.readString();
            _primaryColor = param1.readString();
            _secondaryColor = param1.readString();
            var_811 = param1.readBoolean();
            var_876 = param1.readInteger();
            var_1384 = param1.readBoolean();
        }
        private var var_413: String;
        private var var_811: Boolean;
        private var var_876: int;
        private var var_1384: Boolean;

        private var _groupId: int;

        public function get groupId(): int {
            return _groupId;
        }

        private var _groupName: String;

        public function get groupName(): String {
            return _groupName;
        }

        private var _primaryColor: String;

        public function get primaryColor(): String {
            return _primaryColor;
        }

        private var _secondaryColor: String;

        public function get secondaryColor(): String {
            return _secondaryColor;
        }

        public function get badgeCode(): String {
            return var_413;
        }

        public function get favourite(): Boolean {
            return var_811;
        }

        public function get ownerId(): int {
            return var_876;
        }

        public function get hasForum(): Boolean {
            return var_1384;
        }
    }
}
