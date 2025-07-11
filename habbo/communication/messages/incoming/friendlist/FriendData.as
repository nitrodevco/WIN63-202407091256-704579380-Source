package com.sulake.habbo.communication.messages.incoming.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class FriendData {

        public function FriendData(data: IMessageDataWrapper) {
            super();
            this._id = data.readInteger();
            this._name = data.readString();
            this._gender = data.readInteger();
            this._online = data.readBoolean();
            this._followingAllowed = data.readBoolean();
            this._figure = data.readString();
            this._categoryId = data.readInteger();
            this._motto = data.readString();
            this._realName = data.readString();
            this._facebookId = data.readString();
            this._persistedMessageUser = data.readBoolean();
            this._vipMember = data.readBoolean();
            this._pocketHabboUser = data.readBoolean();
            this._relationshipStatus = data.readShort();
        }
        private var _id: int;
        private var _gender: int;

        private var _online: Boolean;

        private var _followingAllowed: Boolean;

        private var _figure: String;

        private var _categoryId: int;

        private var _motto: String;

        private var _lastAccess: String;
        private var _facebookId: String;
        private var _persistedMessageUser: Boolean;
        private var _vipMember: Boolean;
        private var _pocketHabboUser: Boolean;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        private var _realName: String;

        public function get realName(): String {
            return _realName;
        }

        private var _relationshipStatus: int;

        public function get relationshipStatus(): int {
            return _relationshipStatus;
        }

        public function get id(): int {
            return _id;
        }

        public function get gender(): int {
            return _gender;
        }

        public function get online(): Boolean {
            return _online;
        }

        public function get followingAllowed(): Boolean {
            return _followingAllowed;
        }

        public function get figure(): String {
            return _figure;
        }

        public function get categoryId(): int {
            return _categoryId;
        }

        public function get motto(): String {
            return _motto;
        }

        public function get lastAccess(): String {
            return _lastAccess;
        }

        public function get facebookId(): String {
            return _facebookId;
        }

        public function get persistedMessageUser(): Boolean {
            return _persistedMessageUser;
        }

        public function get vipMember(): Boolean {
            return _vipMember;
        }

        public function get pocketHabboUser(): Boolean {
            return _pocketHabboUser;
        }
    }
}
