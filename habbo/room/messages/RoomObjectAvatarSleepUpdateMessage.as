package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarSleepUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarSleepUpdateMessage(param1: Boolean = false) {
            super();
            var_3901 = param1;
        }
        private var var_3901: Boolean;

        public function get isSleeping(): Boolean {
            return var_3901;
        }
    }
}
