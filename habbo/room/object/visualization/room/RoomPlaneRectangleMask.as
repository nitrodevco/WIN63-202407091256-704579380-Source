package com.sulake.habbo.room.object.visualization.room {
    public class RoomPlaneRectangleMask {

        public function RoomPlaneRectangleMask(param1: Number, param2: Number, param3: Number, param4: Number) {
            super();
            var_1264 = param1;
            var_839 = param2;
            _leftSideLength = param3;
            _rightSideLength = param4;
        }
        private var var_1264: Number = 0;
        private var var_839: Number = 0;

        private var _leftSideLength: Number = 0;

        public function get leftSideLength(): Number {
            return _leftSideLength;
        }

        private var _rightSideLength: Number = 0;

        public function get rightSideLength(): Number {
            return _rightSideLength;
        }

        public function get leftSideLoc(): Number {
            return var_1264;
        }

        public function get rightSideLoc(): Number {
            return var_839;
        }
    }
}
