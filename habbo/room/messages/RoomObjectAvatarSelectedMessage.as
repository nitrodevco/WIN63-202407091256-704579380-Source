package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarSelectedMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarSelectedMessage(param1: Boolean) {
            super();
            _selected = param1;
        }

        private var _selected: Boolean;

        public function get selected(): Boolean {
            return _selected;
        }
    }
}
