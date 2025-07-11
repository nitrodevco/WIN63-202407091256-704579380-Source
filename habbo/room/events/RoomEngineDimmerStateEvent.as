package com.sulake.habbo.room.events {
    public class RoomEngineDimmerStateEvent extends RoomEngineEvent {

        public static const const_453: String = "REDSE_ROOM_COLOR";

        public function RoomEngineDimmerStateEvent(param1: int, param2: int, param3: int, param4: int, param5: int, param6: uint, param7: uint, param8: Boolean = false, param9: Boolean = false) {
            super("REDSE_ROOM_COLOR", param1, param8, param9);
            var_455 = param2;
            var_149 = param3;
            var_4736 = param4;
            var_580 = param5;
            _color = param6;
            var_3376 = param7;
        }
        private var var_149: int;
        private var var_4736: int;
        private var var_580: int;
        private var var_3376: int;

        private var var_455: int;

        private var _color: uint;

        public function get color(): uint {
            return _color;
        }

        public function get state(): int {
            return var_149;
        }

        public function get presetId(): int {
            return var_4736;
        }

        public function get effectId(): int {
            return var_580;
        }

        public function get brightness(): uint {
            return var_3376;
        }

        public function get objectId(): int {
            return var_455;
        }
    }
}
