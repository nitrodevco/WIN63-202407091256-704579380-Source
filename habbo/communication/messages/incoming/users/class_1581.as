package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1581 {

        public function class_1581(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            var_354 = [];
            super();
            var_418 = param1.readInteger();
            _userName = param1.readString();
            var_426 = param1.readString();
            var_962 = param1.readString();
            var_1215 = param1.readString();
            _achievementScore = param1.readInteger();
            var_1232 = param1.readInteger();
            var_1255 = param1.readBoolean();
            var_621 = param1.readBoolean();
            var_1067 = param1.readBoolean();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_354.push(new class_1745(param1));
                _loc3_++;
            }
            var_1054 = param1.readInteger();
            var_960 = param1.readBoolean();
            if (param1.bytesAvailable) {
                var_1563 = param1.readBoolean();
                var_1217 = param1.readInteger();
                var_1550 = param1.readInteger();
                var_975 = param1.readInteger();
                var_1551 = param1.readBoolean();
                var_1576 = param1.readBoolean();
            }
        }
        private var var_418: int;
        private var var_426: String;

        private var var_962: String;

        private var var_1215: String;
        private var var_1232: int;
        private var var_1255: Boolean;
        private var var_621: Boolean;
        private var var_1067: Boolean;
        private var var_354: Array;
        private var var_1054: int;
        private var var_960: Boolean;
        private var var_1563: Boolean;
        private var var_1217: int;
        private var var_1550: int;
        private var var_975: int;
        private var var_1551: Boolean;
        private var var_1576: Boolean;

        private var _userName: String;

        public function get userName(): String {
            return _userName;
        }

        private var _achievementScore: int;

        public function get achievementScore(): int {
            return _achievementScore;
        }

        public function get userId(): int {
            return var_418;
        }

        public function get motto(): String {
            return var_962;
        }

        public function get figure(): String {
            return var_426;
        }

        public function get creationDate(): String {
            return var_1215;
        }

        public function get friendCount(): int {
            return var_1232;
        }

        public function get isFriend(): Boolean {
            return var_1255;
        }

        public function get isFriendRequestSent(): Boolean {
            return var_621;
        }

        public function set isFriendRequestSent(param1: Boolean): void {
            var_621 = param1;
        }

        public function get isOnline(): Boolean {
            return var_1067;
        }

        public function get guilds(): Array {
            return var_354;
        }

        public function get lastAccessSinceInSeconds(): int {
            return var_1054;
        }

        public function get openProfileWindow(): Boolean {
            return var_960;
        }

        public function get accountLevel(): int {
            return var_1217;
        }

        public function get starGemCount(): int {
            return var_975;
        }
    }
}
