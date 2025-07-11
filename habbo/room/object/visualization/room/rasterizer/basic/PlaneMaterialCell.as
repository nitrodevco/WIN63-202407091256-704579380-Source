package com.sulake.habbo.room.object.visualization.room.rasterizer.basic {
    import com.sulake.core.assets.BitmapDataAsset
    import com.sulake.habbo.room.object.visualization.room.utils.Randomizer
    import com.sulake.room.object.visualization.utils.IGraphicAsset
    import com.sulake.room.utils.IVector3d

    import flash.display.BitmapData
    import flash.geom.Matrix
    import flash.geom.Point
    import flash.geom.Rectangle

    public class PlaneMaterialCell {

        public function PlaneMaterialCell(param1: PlaneTexture, param2: Array = null, param3: Array = null, param4: int = 0) {
            var _loc6_: int = 0;
            var _loc7_: IGraphicAsset = null;
            var _loc5_: Point = null;
            var_2911 = [];
            var_2927 = [];
            super();
            var_2260 = param1;
            if (param2 != null && param2.length > 0 && param4 > 0) {
                _loc6_ = 0;
                _loc6_ = 0;
                while (_loc6_ < param2.length) {
                    if ((_loc7_ = param2[_loc6_] as IGraphicAsset) != null) {
                        var_2927.push(_loc7_);
                    }
                    _loc6_++;
                }
                if (var_2927.length > 0) {
                    if (param3 != null) {
                        _loc6_ = 0;
                        while (_loc6_ < param3.length) {
                            if ((_loc5_ = param3[_loc6_] as Point) != null) {
                                var_2911.push(new Point(_loc5_.x, _loc5_.y));
                            }
                            _loc6_++;
                        }
                    }
                    var_3506 = param4;
                }
            }
        }
        private var var_1657: BitmapData = null;
        private var var_2260: PlaneTexture;
        private var var_2911: Array;
        private var var_2927: Array;
        private var var_3506: int = 0;

        public function get isStatic(): Boolean {
            return var_3506 == 0;
        }

        public function dispose(): void {
            if (var_2260 != null) {
                var_2260.dispose();
                var_2260 = null;
            }
            if (var_1657 != null) {
                var_1657.dispose();
                var_1657 = null;
            }
            var_2927 = null;
            var_2911 = null;
        }

        public function clearCache(): void {
            if (var_1657 != null) {
                var_1657.dispose();
                var_1657 = null;
            }
        }

        public function getHeight(param1: IVector3d): int {
            var _loc2_: BitmapData = null;
            if (var_2260 != null) {
                _loc2_ = var_2260.getBitmap(param1);
                if (_loc2_ != null) {
                    return _loc2_.height;
                }
            }
            return 0;
        }

        public function render(param1: IVector3d, param2: int, param3: int): BitmapData {
            var _loc16_: BitmapData = null;
            var _loc4_: BitmapData = null;
            var _loc20_: int = 0;
            var _loc5_: int = 0;
            var _loc7_: Array = null;
            var _loc11_: int = 0;
            var _loc8_: Point = null;
            var _loc6_: IGraphicAsset = null;
            var _loc13_: BitmapDataAsset = null;
            var _loc14_: BitmapData = null;
            var _loc10_: Point = null;
            var _loc9_: Matrix = null;
            var _loc18_: Number = NaN;
            var _loc19_: Number = NaN;
            var _loc17_: Number = NaN;
            var _loc15_: Number = NaN;
            var _loc12_: * = 0;
            if (var_2260 != null) {
                _loc16_ = var_2260.getBitmap(param1);
                try {
                    if (_loc16_ != null && (param2 != 0 || param3 != 0)) {
                        (_loc4_ = new BitmapData(_loc16_.width * 2, _loc16_.height * 2, _loc16_.transparent)).copyPixels(_loc16_, _loc16_.rect, new Point());
                        _loc4_.copyPixels(_loc16_, _loc16_.rect, new Point(_loc16_.width, 0));
                        _loc4_.copyPixels(_loc16_, _loc16_.rect, new Point(0, _loc16_.height));
                        _loc4_.copyPixels(_loc16_, _loc16_.rect, new Point(_loc16_.width, _loc16_.height));
                        _loc16_ = new BitmapData(_loc16_.width, _loc16_.height, _loc16_.transparent);
                        while (param2 < 0) {
                            param2 += _loc16_.width;
                        }
                        while (param3 < 0) {
                            param3 += _loc16_.height;
                        }
                        _loc16_.copyPixels(_loc4_, new Rectangle(param2 % _loc16_.width, param3 % _loc16_.height, _loc16_.width, _loc16_.height), new Point());
                    }
                } catch (e: Error) {
                    return null;
                }
                if (_loc16_ != null) {
                    if (!isStatic) {
                        if (var_1657 != null) {
                            if (var_1657.width != _loc16_.width || var_1657.height != _loc16_.height) {
                                var_1657.dispose();
                                var_1657 = null;
                            } else {
                                var_1657.copyPixels(_loc16_, _loc16_.rect, new Point(0, 0));
                            }
                        }
                        if (var_1657 == null) {
                            var_1657 = _loc16_.clone();
                        }
                        _loc20_ = Math.min(var_3506, var_2911.length);
                        _loc5_ = Math.max(var_3506, var_2911.length);
                        _loc7_ = Randomizer.getArray(var_3506, _loc5_);
                        _loc11_ = 0;
                        while (_loc11_ < _loc20_) {
                            _loc8_ = var_2911[_loc7_[_loc11_]] as Point;
                            _loc6_ = var_2927[_loc11_ % var_2927.length] as IGraphicAsset;
                            if (_loc8_ != null && _loc6_ != null) {
                                if ((_loc13_ = _loc6_.asset as BitmapDataAsset) != null) {
                                    if ((_loc14_ = _loc13_.content as BitmapData) != null) {
                                        _loc10_ = new Point(_loc8_.x + _loc6_.offsetX, _loc8_.y + _loc6_.offsetY);
                                        _loc9_ = new Matrix();
                                        _loc18_ = 1;
                                        _loc19_ = 1;
                                        _loc17_ = 0;
                                        _loc15_ = 0;
                                        if (_loc6_.flipH) {
                                            _loc18_ = -1;
                                            _loc17_ = _loc14_.width;
                                        }
                                        if (_loc6_.flipV) {
                                            _loc19_ = -1;
                                            _loc15_ = _loc14_.height;
                                        }
                                        _loc12_ = (_loc12_ = _loc10_.x + _loc17_) >> 1 << 1;
                                        _loc9_.scale(_loc18_, _loc19_);
                                        _loc9_.translate(_loc12_, _loc10_.y + _loc15_);
                                        var_1657.draw(_loc14_, _loc9_);
                                    }
                                }
                            }
                            _loc11_++;
                        }
                        return var_1657;
                    }
                    return _loc16_;
                }
            }
            return null;
        }

        public function getAssetName(param1: IVector3d): String {
            return var_2260 == null ? null : var_2260.getAssetName(param1);
        }
    }
}
