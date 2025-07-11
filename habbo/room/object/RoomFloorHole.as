package com.sulake.habbo.room.object {
    public class RoomFloorHole {

        public function RoomFloorHole(param1: int, param2: int, param3: int, param4: int) {
            super();
            var_31 = param1;
            var_28 = param2;
            _width = param3;
            var_46 = param4;
        }
        private var var_31: int;
        private var var_28: int;
        private var var_46: int;

        private var _width: int;

        public function get width(): int {
            return _width;
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
    }
}
