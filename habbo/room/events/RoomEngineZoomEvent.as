package com.sulake.habbo.room.events {
    public class RoomEngineZoomEvent extends RoomEngineEvent {

        public static const ROOM_ZOOM: String = "REE_ROOM_ZOOM";

        public function RoomEngineZoomEvent(param1: int, param2: Number, param3: * = false, param4: Boolean = false, param5: Boolean = false) {
            super("REE_ROOM_ZOOM", param1, param4, param5);
            var_360 = param2;
            var_4818 = param3;
        }
        private var var_360: Number = 1;
        private var var_4818: Boolean = false;

        public function get level(): Number {
            return var_360;
        }

        public function get isFlipForced(): Boolean {
            return var_4818;
        }
    }
}
