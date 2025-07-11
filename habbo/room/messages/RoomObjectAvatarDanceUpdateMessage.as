package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarDanceUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarDanceUpdateMessage(param1: int = 0) {
            super();
            var_1021 = param1;
        }
        private var var_1021: int;

        public function get danceStyle(): int {
            return var_1021;
        }
    }
}
