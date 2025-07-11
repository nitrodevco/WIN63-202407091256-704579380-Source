package com.sulake.habbo.room.object.visualization.room.utils {
    import flash.display.BitmapData

    public class PlaneBitmapData {

        public function PlaneBitmapData(param1: BitmapData, param2: int) {
            super();
            _bitmap = param1;
            var_781 = param2;
        }
        private var var_781: int = 0;

        private var _bitmap: BitmapData = null;

        public function get bitmap(): BitmapData {
            return _bitmap;
        }

        public function get timeStamp(): int {
            return var_781;
        }

        public function dispose(): void {
            _bitmap = null;
        }
    }
}
