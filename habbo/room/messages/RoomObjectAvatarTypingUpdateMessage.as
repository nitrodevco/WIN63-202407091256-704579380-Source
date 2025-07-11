package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarTypingUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarTypingUpdateMessage(param1: Boolean = false) {
            super();
            var_514 = param1;
        }
        private var var_514: Boolean;

        public function get isTyping(): Boolean {
            return var_514;
        }
    }
}
