package com.sulake.habbo.room.object.visualization.room.mask {
    import com.sulake.room.object.visualization.utils.IGraphicAsset

    public class PlaneMaskBitmap {

        public static const const_428: Number = -1;

        public static const MAX_NORMAL_COORDINATE_VALUE: Number = 1;

        public function PlaneMaskBitmap(param1: IGraphicAsset, param2: Number = -1, param3: Number = 1, param4: Number = -1, param5: Number = 1) {
            super();
            var_4452 = param2;
            var_4717 = param3;
            var_4718 = param4;
            var_4285 = param5;
            _asset = param1;
        }
        private var var_4452: Number = -1;

        private var var_4717: Number = 1;

        private var var_4718: Number = -1;

        private var var_4285: Number = 1;

        private var _asset: IGraphicAsset = null;

        public function get asset(): IGraphicAsset {
            return _asset;
        }

        public function get normalMinX(): Number {
            return var_4452;
        }

        public function get normalMaxX(): Number {
            return var_4717;
        }

        public function get normalMinY(): Number {
            return var_4718;
        }

        public function get normalMaxY(): Number {
            return var_4285;
        }

        public function dispose(): void {
            _asset = null;
        }
    }
}
