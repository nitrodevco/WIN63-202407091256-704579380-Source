package com.sulake.habbo.room.object.visualization.room {
    public class RoomPlaneBitmapMask {

        public function RoomPlaneBitmapMask(param1: String, param2: Number, param3: Number) {
            super();
            var_329 = param1;
            var_1264 = param2;
            var_839 = param3;
        }
        private var var_329: String = null;
        private var var_1264: Number = 0;
        private var var_839: Number = 0;

        public function get type(): String {
            return var_329;
        }

        public function get leftSideLoc(): Number {
            return var_1264;
        }

        public function get rightSideLoc(): Number {
            return var_839;
        }
    }
}
