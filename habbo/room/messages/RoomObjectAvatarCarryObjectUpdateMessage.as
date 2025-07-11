package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarCarryObjectUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarCarryObjectUpdateMessage(param1: int, param2: String) {
            super();
            var_125 = param1;
            _itemName = param2;
        }
        private var var_125: int;

        private var _itemName: String;

        public function get itemName(): String {
            return _itemName;
        }

        public function get itemType(): int {
            return var_125;
        }
    }
}
