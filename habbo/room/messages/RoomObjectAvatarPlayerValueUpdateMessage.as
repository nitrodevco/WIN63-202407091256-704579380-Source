package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarPlayerValueUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarPlayerValueUpdateMessage(param1: int) {
            super();
            _value = param1;
        }

        private var _value: int;

        public function get value(): int {
            return _value;
        }
    }
}
