package com.sulake.habbo.room.messages {
    import com.sulake.room.messages.RoomObjectUpdateMessage

    public class RoomObjectItemDataUpdateMessage extends RoomObjectUpdateMessage {

        public function RoomObjectItemDataUpdateMessage(param1: String) {
            super(null, null);
            var_199 = param1;
        }
        private var var_199: String;

        public function get itemData(): String {
            return var_199;
        }
    }
}
