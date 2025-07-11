package com.sulake.habbo.room.events {
    import com.sulake.room.events.RoomObjectEvent
    import com.sulake.room.object.IRoomObject

    public class RoomObjectDimmerStateUpdateEvent extends RoomObjectEvent {

        public static const const_453: String = "RODSUE_DIMMER_STATE";

        public function RoomObjectDimmerStateUpdateEvent(param1: IRoomObject, param2: int, param3: int, param4: int, param5: uint, param6: int, param7: Boolean = false, param8: Boolean = false) {
            super("RODSUE_DIMMER_STATE", param1, param7, param8);
            var_149 = param2;
            var_4736 = param3;
            var_580 = param4;
            _color = param5;
            var_3376 = param6;
        }
        private var var_149: int;
        private var var_4736: int;
        private var var_580: int;
        private var var_3376: int;

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
    }
}
