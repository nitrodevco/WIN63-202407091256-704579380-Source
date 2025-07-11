package com.sulake.habbo.room.object.visualization.room.mask {
    import com.sulake.core.utils.Map
    import com.sulake.room.object.visualization.utils.IGraphicAsset
    import com.sulake.room.utils.IVector3d

    public class PlaneMask {

        public function PlaneMask() {
            var_1958 = [];
            super();
            var_2289 = new Map();
            var_713 = new Map();
        }
        private var var_2289: Map;
        private var var_1958: Array;
        private var var_713: Map;
        private var var_2757: PlaneMaskVisualization = null;
        private var var_3986: int = -1;

        public function dispose(): void {
            var _loc2_: PlaneMaskVisualization = null;
            var _loc1_: int = 0;
            if (var_2289 != null) {
                _loc2_ = null;
                _loc1_ = 0;
                while (_loc1_ < var_2289.length) {
                    _loc2_ = var_2289.getWithIndex(_loc1_) as PlaneMaskVisualization;
                    if (_loc2_ != null) {
                        _loc2_.dispose();
                    }
                    _loc1_++;
                }
                var_2289.dispose();
                var_2289 = null;
            }
            var_2757 = null;
            var_1958 = null;
        }

        public function createMaskVisualization(param1: int): PlaneMaskVisualization {
            if (var_2289.getValue(String(param1)) != null) {
                return null;
            }
            var _loc2_: PlaneMaskVisualization = new PlaneMaskVisualization();
            var_2289.add(String(param1), _loc2_);
            var_1958.push(param1);
            var_1958.sort();
            return _loc2_;
        }

        public function getGraphicAsset(param1: Number, param2: IVector3d): IGraphicAsset {
            var _loc3_: PlaneMaskVisualization = getMaskVisualization(param1);
            if (_loc3_ == null) {
                return null;
            }
            return _loc3_.getAsset(param2);
        }

        public function getAssetName(param1: int): String {
            return var_713.getValue(param1);
        }

        public function setAssetName(param1: int, param2: String): void {
            var_713.add(param1, param2);
        }

        protected function getMaskVisualization(param1: int): PlaneMaskVisualization {
            if (param1 == var_3986) {
                return var_2757;
            }
            var _loc2_: int = getSizeIndex(param1);
            if (_loc2_ < var_1958.length) {
                var_2757 = var_2289.getValue(String(var_1958[_loc2_])) as PlaneMaskVisualization;
            } else {
                var_2757 = null;
            }
            var_3986 = param1;
            return var_2757;
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
