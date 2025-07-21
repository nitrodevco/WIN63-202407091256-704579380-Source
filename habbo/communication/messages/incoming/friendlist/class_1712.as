package com.sulake.habbo.communication.messages.incoming.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1712 {

        public function class_1712(param1: IMessageDataWrapper) {
            super();
            this._id = param1.readInteger();
            this._avatarName = param1.readString();
            this._motto = param1.readString();
            this._isOnline = param1.readBoolean();
            this._canFollow = param1.readBoolean();
            param1.readString();
            this._gender = param1.readInteger();
            this._figure = param1.readString();
            this._realName = param1.readString();
        }
        private var _id: int;
        private var _motto: String;

        private var _isOnline: Boolean;

        private var _canFollow: Boolean;

        private var _gender: int;

        private var _figure: String;

        private var _lastOnline: String;

        private var _avatarName: String;

        public function get avatarName(): String {
            return this._avatarName;
        }

        private var _realName: String;

        public function get realName(): String {
            return this._realName;
        }

        public function get avatarId(): int {
            return this._id;
        }

        public function get avatarMotto(): String {
            return this._motto;
        }

        public function get isAvatarOnline(): Boolean {
            return this._isOnline;
        }

        public function get canFollow(): Boolean {
            return this._canFollow;
        }

        public function get avatarGender(): int {
            return this._gender;
        }

        public function get avatarFigure(): String {
            return this._figure;
        }

        public function get lastOnlineDate(): String {
            return this._lastOnline;
        }
    }
}
