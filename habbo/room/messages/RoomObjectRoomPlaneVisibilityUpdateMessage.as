package com.sulake.habbo.room.messages {
    import com.sulake.room.messages.RoomObjectUpdateMessage

    public class RoomObjectRoomPlaneVisibilityUpdateMessage extends RoomObjectUpdateMessage {

        public static const const_1088: String = "RORPVUM_WALL_VISIBILITY";

        public static const const_782: String = "RORPVUM_FLOOR_VISIBILITY";

        public function RoomObjectRoomPlaneVisibilityUpdateMessage(param1: String, param2: Boolean) {
            super(null, null);
            var_329 = param1;
            var_848 = param2;
        }
        private var var_329: String = "";
        private var var_848: Boolean = false;

        public function get type(): String {
            return var_329;
        }

        public function get visible(): Boolean {
            return var_848;
        }
    }
}
