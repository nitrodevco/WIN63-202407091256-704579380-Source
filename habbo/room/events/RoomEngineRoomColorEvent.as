package com.sulake.habbo.room.events {
    public class RoomEngineRoomColorEvent extends RoomEngineEvent {

        public static const ROOM_COLOR: String = "REE_ROOM_COLOR";

        public function RoomEngineRoomColorEvent(param1: int, param2: uint, param3: uint, param4: Boolean, param5: Boolean = false, param6: Boolean = false) {
            super("REE_ROOM_COLOR", param1, param5, param6);
            _color = param2;
            var_4644 = param3;
            var_4425 = param4;
        }
        private var var_4644: uint;

        private var var_4425: Boolean;

        private var _color: uint;

        public function get color(): uint {
            return _color;
        }

        public function get brightness(): uint {
            return var_4644;
        }

        public function get bgOnly(): Boolean {
            return var_4425;
        }
    }
}
