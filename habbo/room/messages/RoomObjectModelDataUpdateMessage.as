package com.sulake.habbo.room.messages {
    import com.sulake.room.messages.RoomObjectUpdateMessage

    public class RoomObjectModelDataUpdateMessage extends RoomObjectUpdateMessage {

        public function RoomObjectModelDataUpdateMessage(param1: String, param2: int) {
            super(null, null);
            _numberKey = param1;
            var_1429 = param2;
        }
        private var var_1429: int;

        private var _numberKey: String;

        public function get numberKey(): String {
            return _numberKey;
        }

        public function get numberValue(): int {
            return var_1429;
        }
    }
}
