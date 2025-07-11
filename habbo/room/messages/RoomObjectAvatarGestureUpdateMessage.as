package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarGestureUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarGestureUpdateMessage(param1: int) {
            super();
            var_471 = param1;
        }
        private var var_471: int = 0;

        public function get gesture(): int {
            return var_471;
        }
    }
}
