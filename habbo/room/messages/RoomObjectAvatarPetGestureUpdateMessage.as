package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarPetGestureUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarPetGestureUpdateMessage(param1: String) {
            super();
            var_471 = param1;
        }
        private var var_471: String;

        public function get gesture(): String {
            return var_471;
        }
    }
}
