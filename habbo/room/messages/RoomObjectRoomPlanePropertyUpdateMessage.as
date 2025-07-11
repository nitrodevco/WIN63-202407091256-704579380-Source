package com.sulake.habbo.room.messages {
    import com.sulake.room.messages.RoomObjectUpdateMessage

    public class RoomObjectRoomPlanePropertyUpdateMessage extends RoomObjectUpdateMessage {

        public static const WALL_THICKNESS: String = "RORPPUM_WALL_THICKNESS";

        public static const FLOOR_THICKNESS: String = "RORPVUM_FLOOR_THICKNESS";

        public function RoomObjectRoomPlanePropertyUpdateMessage(param1: String, param2: Number) {
            super(null, null);
            var_329 = param1;
            _value = param2;
        }
        private var var_329: String = "";

        private var _value: Number = 0;

        public function get value(): Number {
            return _value;
        }

        public function get type(): String {
            return var_329;
        }
    }
}
