package com.sulake.habbo.room.messages {
    import com.sulake.room.messages.RoomObjectUpdateMessage

    public class RoomObjectVisibilityUpdateMessage extends RoomObjectUpdateMessage {

        public static const const_494: String = "ROVUM_ENABLED";

        public static const const_647: String = "ROVUM_DISABLED";

        public function RoomObjectVisibilityUpdateMessage(param1: String) {
            super(null, null);
            var_329 = param1;
        }
        private var var_329: String;

        public function get type(): String {
            return var_329;
        }
    }
}
