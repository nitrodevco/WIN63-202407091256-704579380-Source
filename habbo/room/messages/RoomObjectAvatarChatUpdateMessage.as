package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarChatUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarChatUpdateMessage(param1: int) {
            super();
            var_4313 = param1;
        }
        private var var_4313: int;

        public function get numberOfWords(): int {
            return var_4313;
        }
    }
}
