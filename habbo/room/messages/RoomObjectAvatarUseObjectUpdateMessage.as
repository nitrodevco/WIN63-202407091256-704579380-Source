package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarUseObjectUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarUseObjectUpdateMessage(param1: int) {
            super();
            var_125 = param1;
        }
        private var var_125: int;

        public function get itemType(): int {
            return var_125;
        }
    }
}
