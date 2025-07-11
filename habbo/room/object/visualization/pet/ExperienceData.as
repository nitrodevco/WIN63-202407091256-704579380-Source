package com.sulake.habbo.room.object.visualization.pet {
    import flash.display.BitmapData
    import flash.geom.Matrix
    import flash.geom.Point
    import flash.text.TextField
    import flash.text.TextFormat

    public class ExperienceData {

        public function ExperienceData(param1: BitmapData, param2: Boolean = true) {
            super();
            var_1696 = param1;
            var_4799 = param2;
            if (var_1696 != null) {
                var_2827 = var_1696.clone();
            }
            setExperience(0);
        }
        private var var_1696: BitmapData;
        private var var_4799: Boolean;
        private var var_2827: BitmapData;
        private var _amount: int = -1;

        private var _alpha: int;

        public function get alpha(): int {
            return _alpha;
        }

        public function set alpha(param1: int): void {
            _alpha = param1;
        }

        public function get image(): BitmapData {
            return var_1696;
        }

        public function dispose(): void {
            if (var_2827) {
                var_2827.dispose();
                var_2827 = null;
            }
            if (var_1696 != null) {
                if (var_4799) {
                    var_1696.dispose();
                }
                var_1696 = null;
            }
        }

        public function setExperience(param1: int): void {
            if (_amount == param1 || var_1696 == null) {
                return;
            }
            var_1696.copyPixels(var_2827, var_2827.rect, new Point(0, 0));
            var _loc2_: TextFormat = new TextFormat();
            _loc2_.font = "Volter";
            _loc2_.color = 16777215;
            _loc2_.size = 9;
            var _loc3_: TextField = new TextField();
            _loc3_.embedFonts = true;
            _loc3_.width = 30;
            _loc3_.height = 12;
            _loc3_.background = true;
            _loc3_.backgroundColor = 3871388928;
            _loc3_.defaultTextFormat = _loc2_;
            _loc3_.text = "+" + param1;
            var _loc4_: Matrix;
            (_loc4_ = new Matrix()).translate(15, 19);
            var_1696.draw(_loc3_, _loc4_);
        }
    }
}
