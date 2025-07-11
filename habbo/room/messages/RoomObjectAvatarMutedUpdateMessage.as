package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarMutedUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarMutedUpdateMessage(param1: Boolean = false) {
            super();
            var_4455 = param1;
        }
        private var var_4455: Boolean;

        public function get isMuted(): Boolean {
            return var_4455;
        }
    }
}
