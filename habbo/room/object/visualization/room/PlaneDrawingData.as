package com.sulake.habbo.room.object.visualization.room {
    import com.sulake.room.object.visualization.class_1404

    import flash.geom.Point

    public class PlaneDrawingData implements class_1404 {

        public function PlaneDrawingData(param1: PlaneDrawingData = null, param2: uint = 0, param3: Boolean = false) {
            var_713 = [];
            super();
            var_3078 = [];
            var_3198 = [];
            var_3259 = [];
            var_3098 = [];
            if (param1 != null) {
                var_3078 = param1.var_3078;
                var_3198 = param1.var_3198;
                var_3259 = param1.var_3259;
                var_3098 = param1.var_3098;
            }
            _color = param2;
            var_4339 = param3;
        }
        private var var_30: Number;
        private var var_682: Vector.<Point>;
        private var var_3078: Array;

        private var var_3198: Array;

        private var var_3259: Array;

        private var var_3098: Array;

        private var var_4339: Boolean = false;

        private var var_713: Array;

        private var _color: uint;

        public function get color(): uint {
            return _color;
        }

        public function get z(): Number {
            return var_30;
        }

        public function set z(param1: Number): void {
            var_30 = param1;
        }

        public function get cornerPoints(): Vector.<Point> {
            return var_682;
        }

        public function set cornerPoints(param1: Vector.<Point>): void {
            var_682 = param1;
        }

        public function get maskAssetNames(): Array {
            return var_3078;
        }

        public function get maskAssetLocations(): Array {
            return var_3198;
        }

        public function get maskAssetFlipHs(): Array {
            return var_3259;
        }

        public function get maskAssetFlipVs(): Array {
            return var_3098;
        }

        public function get assetNameColumns(): Array {
            return var_713;
        }

        public function addMask(param1: String, param2: Point, param3: Boolean, param4: Boolean): void {
            var_3078.push(param1);
            var_3198.push(param2);
            var_3259.push(param3);
            var_3098.push(param4);
        }

        public function addAssetColumn(param1: Array): void {
            var_713.push(param1);
        }

        public function isBottomAligned(): Boolean {
            return var_4339;
        }
    }
}
