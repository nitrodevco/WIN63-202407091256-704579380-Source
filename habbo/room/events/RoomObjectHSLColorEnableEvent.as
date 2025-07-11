package com.sulake.habbo.room.events {
    import com.sulake.room.events.RoomObjectEvent
    import com.sulake.room.object.IRoomObject

    public class RoomObjectHSLColorEnableEvent extends RoomObjectEvent {

        public static const ROOM_BACKGROUND_COLOR: String = "ROHSLCEE_ROOM_BACKGROUND_COLOR";

        public function RoomObjectHSLColorEnableEvent(param1: String, param2: IRoomObject, param3: Boolean, param4: int, param5: int, param6: int, param7: Boolean = false, param8: Boolean = false) {
            super(param1, param2, param7, param8);
            var_4261 = param3;
            var_1235 = param4;
            var_1010 = param5;
            var_1227 = param6;
        }
        private var var_4261: Boolean;
        private var var_1235: int;
        private var var_1010: int;
        private var var_1227: int;

        public function get enable(): Boolean {
            return var_4261;
        }

        public function get hue(): int {
            return var_1235;
        }

        public function get saturation(): int {
            return var_1010;
        }

        public function get lightness(): int {
            return var_1227;
        }
    }
}
