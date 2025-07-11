package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1199 {

        public static const TYPE_REGULAR: int = 0;

        public static const TYPE_EXCLUSIVE: int = 1;

        public static const const_155: int = 2;

        public static const TYPE_LARGE: int = 3;

        public static const const_31: int = 4;

        public static const const_160: int = 0;

        public static const const_333: int = 1;

        public static const const_368: int = 2;

        public function class_1199(param1: IMessageDataWrapper) {
            super();
            _groupId = param1.readInteger();
            var_678 = param1.readBoolean();
            var_329 = param1.readInteger();
            _groupName = param1.readString();
            var_363 = param1.readString();
            var_413 = param1.readString();
            var_369 = param1.readInteger();
            _roomName = param1.readString();
            _status = param1.readInteger();
            var_814 = param1.readInteger();
            var_811 = param1.readBoolean();
            var_1215 = param1.readString();
            var_385 = param1.readBoolean();
            _isAdmin = param1.readBoolean();
            _ownerName = param1.readString();
            var_1183 = param1.readBoolean();
            var_955 = param1.readBoolean();
            var_951 = param1.readInteger();
            var_914 = param1.readBoolean();
        }
        private var var_678: Boolean;

        private var var_329: int;
        private var var_363: String;
        private var var_413: String;
        private var var_369: int = -1;
        private var var_814: int;
        private var var_811: Boolean;
        private var var_1215: String;
        private var var_385: Boolean;
        private var var_1183: Boolean;
        private var var_914: Boolean;
        private var var_955: Boolean;
        private var var_951: int;

        private var _groupId: int;

        public function get groupId(): int {
            return _groupId;
        }

        private var _groupName: String;

        public function get groupName(): String {
            return _groupName;
        }

        private var _roomName: String = "";

        public function get roomName(): String {
            return _roomName;
        }

        private var _status: int;

        public function get status(): int {
            return _status;
        }

        private var _isAdmin: Boolean;

        public function get isAdmin(): Boolean {
            return _isAdmin;
        }

        private var _ownerName: String;

        public function get ownerName(): String {
            return _ownerName;
        }

        public function get isGuild(): Boolean {
            return var_678;
        }

        public function get type(): int {
            return var_329;
        }

        public function get description(): String {
            return var_363;
        }

        public function get badgeCode(): String {
            return var_413;
        }

        public function get roomId(): int {
            return var_369;
        }

        public function get totalMembers(): int {
            return var_814;
        }

        public function get favourite(): Boolean {
            return var_811;
        }

        public function get creationDate(): String {
            return var_1215;
        }

        public function get isOwner(): Boolean {
            return var_385;
        }

        public function get openDetails(): Boolean {
            return var_1183;
        }

        public function get membersCanDecorate(): Boolean {
            return var_955;
        }

        public function get pendingMemberCount(): int {
            return var_951;
        }

        public function get hasBoard(): Boolean {
            return var_914;
        }

        public function get joiningAllowed(): Boolean {
            return _status == 0 && (var_329 == 0 || var_329 == 4);
        }

        public function get requestMembershipAllowed(): Boolean {
            return _status == 0 && var_329 == 1;
        }

        public function get leaveAllowed(): Boolean {
            return var_678 && !var_385 && _status == 1;
        }
    }
}
