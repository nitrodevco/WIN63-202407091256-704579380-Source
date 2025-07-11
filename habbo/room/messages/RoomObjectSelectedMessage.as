package com.sulake.habbo.room.messages {
    public class RoomObjectSelectedMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectSelectedMessage(param1: Boolean) {
            super();
            _selected = param1;
        }

        private var _selected: Boolean;

        public function get selected(): Boolean {
            return _selected;
        }
    }
}
