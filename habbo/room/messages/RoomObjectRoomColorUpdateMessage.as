package com.sulake.habbo.room.messages {
    import com.sulake.room.messages.RoomObjectUpdateMessage

    public class RoomObjectRoomColorUpdateMessage extends RoomObjectUpdateMessage {

        public static const BACKGROUND_COLOR: String = "RORCUM_BACKGROUND_COLOR";

        public function RoomObjectRoomColorUpdateMessage(param1: String, param2: uint, param3: int, param4: Boolean) {
            super(null, null);
            var_329 = param1;
            _color = param2;
            var_1022 = param3;
            var_4425 = param4;
        }
        private var var_329: String = "";
        private var var_1022: int = 0;

        private var var_4425: Boolean = true;

        private var _color: uint = 0;

        public function get color(): uint {
            return _color;
        }

        public function get type(): String {
            return var_329;
        }

        public function get light(): uint {
            return var_1022;
        }

        public function get bgOnly(): Boolean {
            return var_4425;
        }
    }
}
