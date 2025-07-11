package com.sulake.habbo.room.messages {
    import com.sulake.room.messages.RoomObjectUpdateMessage

    public class RoomObjectRoomFloorHoleUpdateMessage extends RoomObjectUpdateMessage {

        public static const ADD_HOLE: String = "RORPFHUM_ADD";

        public static const REMOVE_HOLE: String = "RORPFHUM_REMOVE";

        public function RoomObjectRoomFloorHoleUpdateMessage(param1: String, param2: int, param3: int = 0, param4: int = 0, param5: int = 0, param6: int = 0, param7: Boolean = false) {
            super(null, null);
            var_329 = param1;
            var_280 = param2;
            var_31 = param3;
            var_28 = param4;
            _width = param5;
            var_46 = param6;
            var_787 = param7;
        }
        private var var_329: String = "";
        private var var_280: int;
        private var var_31: int;
        private var var_28: int;
        private var var_46: int;

        private var var_787: Boolean;

        private var _width: int;

        public function get width(): int {
            return _width;
        }

        public function get type(): String {
            return var_329;
        }

        public function get id(): int {
            return var_280;
        }

        public function get x(): int {
            return var_31;
        }

        public function get y(): int {
            return var_28;
        }

        public function get height(): int {
            return var_46;
        }

        public function get invert(): Boolean {
            return var_787;
        }
    }
}
