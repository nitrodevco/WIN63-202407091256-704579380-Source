package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1184 implements class_1183 {

        public function class_1184(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            var _loc2_: int = 0;
            super();
            var_654 = [];
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_654.push(new class_1677(param1.readInteger(), param1.readString(), param1.readBoolean()));
                _loc3_++;
            }
            var_385 = param1.readBoolean();
            _groupId = param1.readInteger();
            _groupName = param1.readString();
            var_1015 = param1.readString();
            var_1180 = param1.readInteger();
            var_841 = param1.readInteger();
            var_1361 = param1.readInteger();
            var_1424 = param1.readInteger();
            var_1279 = param1.readInteger();
            var_173 = param1.readBoolean();
            var_96 = param1.readString();
            var_669 = [];
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_669.push(new class_1654(param1));
                _loc3_++;
            }
            var_413 = param1.readString();
            var_1470 = param1.readInteger();
        }
        private var var_654: Array;
        private var var_385: Boolean;
        private var var_1015: String;
        private var var_1180: int;
        private var var_841: int;
        private var var_1361: int;
        private var var_173: Boolean;
        private var var_96: String;
        private var var_1424: int;
        private var var_1279: int;
        private var var_669: Array;
        private var var_413: String;
        private var var_1470: int;

        private var _groupId: int;

        public function get groupId(): int {
            return _groupId;
        }

        private var _groupName: String;

        public function get groupName(): String {
            return _groupName;
        }

        public function get ownedRooms(): Array {
            return var_654;
        }

        public function get exists(): Boolean {
            return true;
        }

        public function get isOwner(): Boolean {
            return var_385;
        }

        public function get groupDesc(): String {
            return var_1015;
        }

        public function get baseRoomId(): int {
            return var_1180;
        }

        public function get primaryColorId(): int {
            return var_841;
        }

        public function get secondaryColorId(): int {
            return var_1361;
        }

        public function get badgeSettings(): Array {
            return var_669;
        }

        public function get locked(): Boolean {
            return var_173;
        }

        public function get url(): String {
            return var_96;
        }

        public function get guildType(): int {
            return var_1424;
        }

        public function get guildRightsLevel(): int {
            return var_1279;
        }

        public function get badgeCode(): String {
            return var_413;
        }

        public function get membershipCount(): int {
            return var_1470;
        }
    }
}
