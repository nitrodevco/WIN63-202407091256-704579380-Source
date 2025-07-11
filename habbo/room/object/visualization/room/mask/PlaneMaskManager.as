package com.sulake.habbo.room.object.visualization.room.mask {
    import com.sulake.core.assets.BitmapDataAsset
    import com.sulake.core.utils.Map
    import com.sulake.room.object.visualization.utils.IGraphicAsset
    import com.sulake.room.object.visualization.utils.class_3367
    import com.sulake.room.utils.IVector3d
    import com.sulake.room.utils.class_1781

    import flash.display.BitmapData
    import flash.geom.Matrix
    import flash.geom.Point

    public class PlaneMaskManager {

        public function PlaneMaskManager() {
            super();
            var_461 = new Map();
        }
        private var var_2647: class_3367 = null;
        private var var_461: Map = null;
        private var var_47: XML = null;

        public function get data(): XML {
            return var_47;
        }

        public function dispose(): void {
            var _loc1_: int = 0;
            var _loc2_: PlaneMask = null;
            var_2647 = null;
            var_47 = null;
            if (var_461 != null) {
                _loc1_ = 0;
                while (_loc1_ < var_461.length) {
                    _loc2_ = var_461.getWithIndex(_loc1_) as PlaneMask;
                    if (_loc2_ != null) {
                        _loc2_.dispose();
                    }
                    _loc1_++;
                }
                var_461.dispose();
            }
        }

        public function initialize(param1: XML): void {
            var_47 = param1;
        }

        public function initializeAssetCollection(param1: class_3367): void {
            if (data == null) {
                return;
            }
            var_2647 = param1;
            parseMasks(data, param1);
        }

        public function updateMask(param1: BitmapData, param2: String, param3: Number, param4: IVector3d, param5: int, param6: int): Boolean {
            var _loc15_: IGraphicAsset = null;
            var _loc9_: BitmapDataAsset = null;
            var _loc10_: BitmapData = null;
            var _loc8_: Point = null;
            var _loc7_: Matrix = null;
            var _loc13_: Number = NaN;
            var _loc14_: Number = NaN;
            var _loc12_: Number = NaN;
            var _loc11_: Number = NaN;
            var _loc16_: PlaneMask;
            if ((_loc16_ = var_461.getValue(param2) as PlaneMask) != null) {
                if ((_loc15_ = _loc16_.getGraphicAsset(param3, param4)) != null) {
                    if ((_loc9_ = _loc15_.asset as BitmapDataAsset) != null) {
                        if ((_loc10_ = _loc9_.content as BitmapData) != null) {
                            _loc8_ = new Point(param5 + _loc15_.offsetX, param6 + _loc15_.offsetY);
                            _loc7_ = new Matrix();
                            _loc13_ = 1;
                            _loc14_ = 1;
                            _loc12_ = 0;
                            _loc11_ = 0;
                            if (_loc15_.flipH) {
                                _loc13_ = -1;
                                _loc12_ = _loc10_.width;
                            }
                            if (_loc15_.flipV) {
                                _loc14_ = -1;
                                _loc11_ = _loc10_.height;
                            }
                            _loc7_.scale(_loc13_, _loc14_);
                            _loc7_.translate(_loc8_.x + _loc12_, _loc8_.y + _loc11_);
                            param1.draw(_loc10_, _loc7_);
                        }
                    }
                }
            }
            return true;
        }

        public function getMask(param1: String): PlaneMask {
            return var_461.getValue(param1) as PlaneMask;
        }

        private function parseMasks(param1: XML, param2: class_3367): void {
            var _loc5_: int = 0;
            var _loc16_: XML = null;
            var _loc14_: String = null;
            var _loc15_: PlaneMask = null;
            var _loc9_: XMLList = null;
            var _loc7_: int = 0;
            var _loc13_: XML = null;
            var _loc11_: int = 0;
            var _loc4_: PlaneMaskVisualization = null;
            var _loc3_: XMLList = null;
            var _loc12_: String = null;
            if (param1 == null || param2 == null) {
                return;
            }
            var _loc10_: Array = ["id"];
            var _loc8_: Array = ["size"];
            var _loc6_: XMLList = param1.mask;
            _loc5_ = 0;
            while (_loc5_ < _loc6_.length()) {
                _loc16_ = _loc6_[_loc5_];
                if (class_1781.checkRequiredAttributes(_loc16_, _loc10_)) {
                    _loc14_ = _loc16_.@id;
                    if (var_461.getValue(_loc14_) == null) {
                        _loc15_ = new PlaneMask();
                        _loc9_ = _loc16_.maskVisualization;
                        _loc7_ = 0;
                        while (_loc7_ < _loc9_.length()) {
                            _loc13_ = _loc9_[_loc7_];
                            if (class_1781.checkRequiredAttributes(_loc13_, _loc8_)) {
                                _loc11_ = parseInt(_loc13_.@size);
                                if ((_loc4_ = _loc15_.createMaskVisualization(_loc11_)) != null) {
                                    _loc3_ = _loc13_.bitmap;
                                    _loc12_ = parseMaskBitmaps(_loc3_, _loc4_, param2);
                                    _loc15_.setAssetName(_loc11_, _loc12_);
                                }
                            }
                            _loc7_++;
                        }
                        var_461.add(_loc14_, _loc15_);
                    }
                }
                _loc5_++;
            }
        }

        private function parseMaskBitmaps(param1: XMLList, param2: PlaneMaskVisualization, param3: class_3367): String {
            var _loc8_: int = 0;
            var _loc4_: XML = null;
            var _loc6_: Number = NaN;
            var _loc12_: Number = NaN;
            var _loc9_: Number = NaN;
            var _loc5_: Number = NaN;
            var _loc7_: String = null;
            var _loc11_: IGraphicAsset = null;
            if (param1 == null) {
                return null;
            }
            var _loc10_: * = null;
            _loc8_ = 0;
            while (_loc8_ < param1.length()) {
                _loc4_ = param1[_loc8_];
                if (class_1781.checkRequiredAttributes(_loc4_, ["assetName"])) {
                    _loc6_ = -1;
                    _loc12_ = 1;
                    _loc9_ = -1;
                    _loc5_ = 1;
                    if (String(_loc4_.@normalMinX) != "") {
                        _loc6_ = parseFloat(_loc4_.@normalMinX);
                    }
                    if (String(_loc4_.@normalMaxX) != "") {
                        _loc12_ = parseFloat(_loc4_.@normalMaxX);
                    }
                    if (String(_loc4_.@normalMinY) != "") {
                        _loc9_ = parseFloat(_loc4_.@normalMinY);
                    }
                    if (String(_loc4_.@normalMaxY) != "") {
                        _loc5_ = parseFloat(_loc4_.@normalMaxY);
                    }
                    _loc7_ = _loc4_.@assetName;
                    if ((_loc11_ = param3.getAsset(_loc7_)) != null) {
                        if (!_loc11_.flipH) {
                            _loc10_ = _loc7_;
                        }
                        param2.addBitmap(_loc11_, _loc6_, _loc12_, _loc9_, _loc5_);
                    }
                }
                _loc8_++;
            }
            return _loc10_;
        }
    }
}
