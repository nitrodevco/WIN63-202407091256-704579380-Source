package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarSignUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarSignUpdateMessage(param1: int) {
            super();
            var_3948 = param1;
        }
        private var var_3948: int;

        public function get signType(): int {
            return var_3948;
        }
    }
}
