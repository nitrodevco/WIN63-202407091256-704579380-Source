package com.sulake.habbo.communication.messages.incoming.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1712 {

        public function class_1712(param1: IMessageDataWrapper) {
            super();
            this.var_894 = param1.readInteger();
            this._avatarName = param1.readString();
            this.var_1574 = param1.readString();
            this.var_1521 = param1.readBoolean();
            this.var_1581 = param1.readBoolean();
            param1.readString();
            this.var_1543 = param1.readInteger();
            this.var_1536 = param1.readString();
            this._realName = param1.readString();
        }
        private var var_894: int;
        private var var_1574: String;

        private var var_1521: Boolean;

        private var var_1581: Boolean;

        private var var_1543: int;

        private var var_1536: String;

        private var var_1582: String;

        private var _avatarName: String;

        public function get avatarName(): String {
            return this._avatarName;
        }

        private var _realName: String;

        public function get realName(): String {
            return this._realName;
        }

        public function get avatarId(): int {
            return this.var_894;
        }

        public function get avatarMotto(): String {
            return this.var_1574;
        }

        public function get isAvatarOnline(): Boolean {
            return this.var_1521;
        }

        public function get canFollow(): Boolean {
            return this.var_1581;
        }

        public function get avatarGender(): int {
            return this.var_1543;
        }

        public function get avatarFigure(): String {
            return this.var_1536;
        }

        public function get lastOnlineDate(): String {
            return this.var_1582;
        }
    }
}
