package com.sulake.habbo.room.object.visualization.room.rasterizer.basic {
    import com.sulake.core.utils.Map
    import com.sulake.room.utils.IRoomGeometry

    public class Plane {

        public function Plane() {
            var_1958 = [];
            super();
            var_2110 = new Map();
        }
        private var var_2110: Map;
        private var var_1958: Array;
        private var var_2903: PlaneVisualization = null;
        private var var_3986: int = -1;

        public function isStatic(param1: int): Boolean {
            return true;
        }

        public function dispose(): void {
            var _loc1_: PlaneVisualization = null;
            var _loc2_: int = 0;
            if (var_2110 != null) {
                _loc1_ = null;
                _loc2_ = 0;
                while (_loc2_ < var_2110.length) {
                    _loc1_ = var_2110.getWithIndex(_loc2_) as PlaneVisualization;
                    if (_loc1_ != null) {
                        _loc1_.dispose();
                    }
                    _loc2_++;
                }
                var_2110.dispose();
                var_2110 = null;
            }
            var_2903 = null;
            var_1958 = null;
        }

        public function clearCache(): void {
            var _loc2_: int = 0;
            var _loc1_: PlaneVisualization = null;
            _loc2_ = 0;
            while (_loc2_ < var_2110.length) {
                _loc1_ = var_2110.getWithIndex(_loc2_) as PlaneVisualization;
                if (_loc1_ != null) {
                    _loc1_.clearCache();
                }
                _loc2_++;
            }
        }

        public function createPlaneVisualization(param1: int, param2: int, param3: IRoomGeometry): PlaneVisualization {
            if (var_2110.getValue(String(param1)) != null) {
                return null;
            }
            var _loc4_: PlaneVisualization = new PlaneVisualization(param1, param2, param3);
            var_2110.add(String(param1), _loc4_);
            var_1958.push(param1);
            var_1958.sort();
            return _loc4_;
        }

        public function getLayers(): Array {
            return getPlaneVisualization(var_3986).getLayers();
        }

        protected function getPlaneVisualization(param1: int): PlaneVisualization {
            if (param1 == var_3986) {
                return var_2903;
            }
            var _loc2_: int = getSizeIndex(param1);
            if (_loc2_ < var_1958.length) {
                var_2903 = var_2110.getValue(String(var_1958[_loc2_])) as PlaneVisualization;
            } else {
                var_2903 = null;
            }
            var_3986 = param1;
            return var_2903;
        }

        private function getSizeIndex(param1: int): int {
            var _loc3_: int = 0;
            var _loc2_: * = 0;
            _loc3_ = 1;
            while (_loc3_ < var_1958.length) {
                if (var_1958[_loc3_] > param1) {
                    if (var_1958[_loc3_] - param1 < param1 - var_1958[_loc3_ - 1]) {
                        _loc2_ = _loc3_;
                    }
                    break;
                }
                _loc2_ = _loc3_;
                _loc3_++;
            }
            return _loc2_;
        }
    }
}
