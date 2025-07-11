package com.sulake.habbo.room.object.visualization.room.rasterizer.animated {
    import flash.display.BitmapData
    import flash.geom.Point

    public class AnimationItem {

        public function AnimationItem(param1: Number, param2: Number, param3: Number, param4: Number, param5: BitmapData) {
            super();
            var_31 = param1;
            var_28 = param2;
            var_3591 = param3;
            var_3590 = param4;
            if (isNaN(var_31)) {
                var_31 = 0;
            }
            if (isNaN(var_28)) {
                var_28 = 0;
            }
            if (isNaN(var_3591)) {
                var_3591 = 0;
            }
            if (isNaN(var_3590)) {
                var_3590 = 0;
            }
            _bitmapData = param5;
        }
        private var var_31: Number = 0;
        private var var_28: Number = 0;
        private var var_3591: Number = 0;
        private var var_3590: Number = 0;

        private var _bitmapData: BitmapData = null;

        public function get bitmapData(): BitmapData {
            return _bitmapData;
        }

        public function dispose(): void {
            _bitmapData = null;
        }

        public function getPosition(param1: int, param2: int, param3: Number, param4: Number, param5: int): Point {
            var _loc6_: Number = var_31;
            var _loc7_: Number = var_28;
            if (param3 > 0) {
                _loc6_ += var_3591 / param3 * param5 / 1000;
            }
            if (param4 > 0) {
                _loc7_ += var_3590 / param4 * param5 / 1000;
            }
            var _loc8_: int = _loc6_ % 1 * param1;
            var _loc9_: int = _loc7_ % 1 * param2;
            return new Point(_loc8_, _loc9_);
        }
    }
}
