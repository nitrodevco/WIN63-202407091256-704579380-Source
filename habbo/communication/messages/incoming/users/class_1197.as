package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1197 implements class_1183 {

        public function class_1197(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            var _loc2_: int = 0;
            super();
            var_1031 = param1.readInteger();
            var_654 = [];
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_654.push(new class_1677(param1.readInteger(), param1.readString(), param1.readBoolean()));
                _loc3_++;
            }
            _loc2_ = param1.readInteger();
            var_669 = [];
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_669.push(new class_1654(param1));
                _loc3_++;
            }
        }
        private var var_1031: int;
        private var var_654: Array;
        private var var_669: Array;

        public function get costInCredits(): int {
            return var_1031;
        }

        public function get ownedRooms(): Array {
            return var_654;
        }

        public function get exists(): Boolean {
            return false;
        }

        public function get isOwner(): Boolean {
            return true;
        }

        public function get groupId(): int {
            return 0;
        }

        public function get groupName(): String {
            return "";
        }

        public function get groupDesc(): String {
            return "";
        }

        public function get baseRoomId(): int {
            return 0;
        }

        public function get primaryColorId(): int {
            return 0;
        }

        public function get secondaryColorId(): int {
            return 0;
        }

        public function get badgeSettings(): Array {
            return var_669;
        }

        public function get locked(): Boolean {
            return false;
        }

        public function get url(): String {
            return "";
        }

        public function get guildType(): int {
            return 0;
        }

        public function get guildRightsLevel(): int {
            return 0;
        }

        public function get badgeCode(): String {
            return "";
        }

        public function get membershipCount(): int {
            return 0;
        }
    }
}
