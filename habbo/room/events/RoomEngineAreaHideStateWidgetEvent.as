package com.sulake.habbo.room.events {
    public class RoomEngineAreaHideStateWidgetEvent extends RoomEngineToWidgetEvent {

        public static const UPDATE_STATE_AREA_HIDE: String = "RETWE_UPDATE_STATE_AREA_HIDE";

        public function RoomEngineAreaHideStateWidgetEvent(param1: int, param2: int, param3: int, param4: Boolean) {
            super("RETWE_UPDATE_STATE_AREA_HIDE", param1, param2, param3, null, null, null);
            var_1149 = param4;
        }
        private var var_1149: Boolean;

        public function get isOn(): Boolean {
            return var_1149;
        }
    }
}
