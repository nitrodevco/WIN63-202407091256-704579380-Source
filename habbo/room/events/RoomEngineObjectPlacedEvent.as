package com.sulake.habbo.room.events {
    public class RoomEngineObjectPlacedEvent extends RoomEngineObjectEvent {

        public function RoomEngineObjectPlacedEvent(param1: String, param2: int, param3: int, param4: int, param5: String, param6: Number, param7: Number, param8: Number, param9: int, param10: Boolean, param11: Boolean, param12: Boolean, param13: String, param14: Boolean = false, param15: Boolean = false) {
            super(param1, param2, param3, param4, param14, param15);
            var_1126 = param5;
            var_31 = param6;
            var_28 = param7;
            var_30 = param8;
            var_1210 = param9;
            _placedInRoom = param10;
            _placedOnFloor = param11;
            _placedOnWall = param12;
            var_4685 = param13;
        }
        private var var_1126: String = "";
        private var var_31: Number = 0;
        private var var_28: Number = 0;
        private var var_30: Number = 0;
        private var var_1210: int = 0;
        private var var_4685: String = null;

        private var _placedInRoom: Boolean = false;

        public function get placedInRoom(): Boolean {
            return _placedInRoom;
        }

        private var _placedOnFloor: Boolean = false;

        public function get placedOnFloor(): Boolean {
            return _placedOnFloor;
        }

        private var _placedOnWall: Boolean = false;

        public function get placedOnWall(): Boolean {
            return _placedOnWall;
        }

        public function get wallLocation(): String {
            return var_1126;
        }

        public function get x(): Number {
            return var_31;
        }

        public function get y(): Number {
            return var_28;
        }

        public function get z(): Number {
            return var_30;
        }

        public function get direction(): int {
            return var_1210;
        }

        public function get instanceData(): String {
            return var_4685;
        }
    }
}
