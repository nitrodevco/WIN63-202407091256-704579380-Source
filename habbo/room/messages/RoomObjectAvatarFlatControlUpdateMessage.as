package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarFlatControlUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarFlatControlUpdateMessage(param1: String) {
            super();
            var_4722 = param1;
        }
        private var var_4722: String;

        private var _isAdmin: Boolean = false;

        public function get isAdmin(): Boolean {
            return _isAdmin;
        }

        public function get rawData(): String {
            return var_4722;
        }
    }
}
