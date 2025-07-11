package com.sulake.habbo.room.object.visualization.room.rasterizer.basic {
    import com.sulake.habbo.room.object.visualization.room.utils.Randomizer
    import com.sulake.room.utils.IVector3d
    import com.sulake.room.utils.Vector3d

    import flash.display.BitmapData
    import flash.geom.Point
    import flash.geom.Rectangle

    public class PlaneMaterialCellMatrix {

        public static const REPEAT_MODE_ALL: int = 1;

        public static const REPEAT_MODE_BORDERS: int = 2;

        public static const REPEAT_MODE_CENTER: int = 3;

        public static const REPEAT_MODE_FIRST: int = 4;

        public static const REPEAT_MODE_LAST: int = 5;

        public static const REPEAT_MODE_RANDOM: int = 6;

        public static const REPEAT_MODE_DEFAULT: int = 1;

        public static const const_428: Number = -1;

        public static const MAX_NORMAL_COORDINATE_VALUE: Number = 1;

        public static const ALIGN_TOP: int = 1;

        public static const ALIGN_BOTTOM: int = 2;

        public static const ALIGN_DEFAULT: int = 1;

        private static function nextRandomColumnIndex(param1: int): int {
            var _loc2_: Array = Randomizer.getValues(1, 0, param1 * 17631);
            return _loc2_[0] % param1;
        }

        public function PlaneMaterialCellMatrix(param1: int, param2: int = 1, param3: int = 1, param4: Number = -1, param5: Number = 1, param6: Number = -1, param7: Number = 1) {
            var _loc8_: int = 0;
            var_2000 = [];
            super();
            if (param1 < 1) {
                param1 = 1;
            }
            _loc8_ = 0;
            while (_loc8_ < param1) {
                var_2000.push(null);
                _loc8_++;
            }
            var_3706 = param2;
            var_3826 = param3;
            var_4452 = param4;
            var_4717 = param5;
            var_4718 = param6;
            var_4285 = param7;
            if (var_3706 == 6) {
                var_3639 = false;
            }
        }
        private var var_2000: Array;
        private var var_3706: int = 1;
        private var var_3826: int = 1;
        private var var_1657: BitmapData;
        private var _cachedBitmapNormal: Vector3d = null;
        private var var_2203: int = 0;
        private var var_3602: Boolean = false;
        private var var_3639: Boolean = true;
        private var var_4452: Number = -1;
        private var var_4717: Number = 1;
        private var var_4718: Number = -1;
        private var var_4285: Number = 1;

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

        public function get isStatic(): Boolean {
            return var_3639;
        }

        public function isBottomAligned(): Boolean {
            return var_3826 == 2;
        }

        public function dispose(): void {
            if (var_1657 != null) {
                var_1657.dispose();
                var_1657 = null;
            }
            if (_cachedBitmapNormal != null) {
                _cachedBitmapNormal = null;
            }
        }

        public function clearCache(): void {
            var _loc2_: int = 0;
            var _loc1_: PlaneMaterialCellColumn = null;
            if (!var_3602) {
                return;
            }
            if (var_1657 != null) {
                var_1657.dispose();
                var_1657 = null;
            }
            if (_cachedBitmapNormal != null) {
                _cachedBitmapNormal.x = 0;
                _cachedBitmapNormal.y = 0;
                _cachedBitmapNormal.z = 0;
            }
            var_2203 = 0;
            _loc2_ = 0;
            while (_loc2_ < var_2000.length) {
                _loc1_ = var_2000[_loc2_] as PlaneMaterialCellColumn;
                if (_loc1_ != null) {
                    _loc1_.clearCache();
                }
                _loc2_++;
            }
            var_3602 = false;
        }

        public function createColumn(param1: int, param2: int, param3: Array, param4: int = 1): Boolean {
            if (param1 < 0 || param1 >= var_2000.length) {
                return false;
            }
            var _loc6_: PlaneMaterialCellColumn = new PlaneMaterialCellColumn(param2, param3, param4);
            var _loc5_: PlaneMaterialCellColumn;
            if ((_loc5_ = var_2000[param1] as PlaneMaterialCellColumn) != null) {
                _loc5_.dispose();
            }
            var_2000[param1] = _loc6_;
            if (_loc6_ != null && !_loc6_.isStatic) {
                var_3639 = false;
            }
            return true;
        }

        public function render(param1: BitmapData, param2: int, param3: int, param4: IVector3d, param5: Boolean, param6: int, param7: int, param8: Boolean): BitmapData {
            var _loc12_: int = 0;
            var _loc11_: PlaneMaterialCellColumn = null;
            var _loc10_: BitmapData = null;
            if (param2 < 1) {
                param2 = 1;
            }
            if (param3 < 1) {
                param3 = 1;
            }
            if (param1 == null || param1.width != param2 || param1.height != param3) {
                param1 = null;
            }
            if (_cachedBitmapNormal == null) {
                _cachedBitmapNormal = new Vector3d();
            }
            if (isStatic) {
                if (var_1657 != null) {
                    if (var_1657.width == param2 && var_1657.height == param3 && Vector3d.isEqual(_cachedBitmapNormal, param4)) {
                        if (param1 != null) {
                            copyCachedBitmapOnCanvas(param1, var_2203, param7, param8);
                            return param1;
                        }
                        return var_1657;
                    }
                    var_1657.dispose();
                    var_1657 = null;
                }
            } else if (var_1657 != null) {
                if (var_1657.width == param2 && var_1657.height == param3) {
                    var_1657.fillRect(var_1657.rect, 16777215);
                } else {
                    var_1657.dispose();
                    var_1657 = null;
                }
            }
            var_3602 = true;
            _cachedBitmapNormal.assign(param4);
            if (!param5) {
                var_2203 = param3;
                if (var_1657 == null) {
                    try {
                        var_1657 = new BitmapData(param2, param3, true, 4294967295);
                    } catch (e: Error) {
                        return null;
                    }
                } else {
                    var_1657.fillRect(var_1657.rect, 4294967295);
                }
                if (param1 != null) {
                    copyCachedBitmapOnCanvas(param1, param3, param7, param8);
                    return param1;
                }
                return var_1657;
            }
            if (var_1657 == null) {
                var_2203 = param3;
                try {
                    var_1657 = new BitmapData(param2, param3, true, 16777215);
                } catch (e: Error) {
                    var_1657 = null;
                    return null;
                }
            }
            var _loc9_: Array = [];
            _loc12_ = 0;
            while (_loc12_ < var_2000.length) {
                if ((_loc11_ = var_2000[_loc12_] as PlaneMaterialCellColumn) != null) {
                    if ((_loc10_ = _loc11_.render(param3, param4, param6, param7)) != null) {
                        _loc9_.push(_loc10_);
                    }
                }
                _loc12_++;
            }
            if (_loc9_.length == 0) {
                if (param1 != null) {
                    return param1;
                }
                return var_1657;
            }
            var _loc13_: int = 0;
            switch (var_3706 - 2) {
                case 0:
                    _loc13_ = renderRepeatBorders(var_1657, _loc9_);
                    break;
                case 1:
                    _loc13_ = renderRepeatCenter(var_1657, _loc9_);
                    break;
                case 2:
                    _loc13_ = renderRepeatFirst(var_1657, _loc9_);
                    break;
                case 3:
                    _loc13_ = renderRepeatLast(var_1657, _loc9_);
                    break;
                case 4:
                    _loc13_ = renderRepeatRandom(var_1657, _loc9_);
                    break;
                default:
                    _loc13_ = renderRepeatAll(var_1657, _loc9_);
            }
            var_2203 = _loc13_;
            if (param1 != null) {
                copyCachedBitmapOnCanvas(param1, _loc13_, param7, param8);
                return param1;
            }
            return var_1657;
        }

        public function getColumns(param1: int): Array {
            var _loc2_: Array = null;
            var _loc4_: int = 0;
            var _loc3_: PlaneMaterialCellColumn = null;
            if (var_3706 == 6) {
                _loc2_ = [];
                _loc4_ = 0;
                while (_loc4_ < param1) {
                    _loc3_ = var_2000[nextRandomColumnIndex(var_2000.length)];
                    if (_loc3_ == null) {
                        break;
                    }
                    _loc2_.push(_loc3_);
                    if (_loc3_.width <= 1) {
                        break;
                    }
                    _loc4_ += _loc3_.width;
                }
                return _loc2_;
            }
            return var_2000;
        }

        private function copyCachedBitmapOnCanvas(param1: BitmapData, param2: int, param3: int, param4: Boolean): void {
            if (param1 == null || var_1657 == null || param1 == var_1657) {
                return;
            }
            if (!param4) {
                param3 = param1.height - param2 - param3;
            }
            var _loc5_: Rectangle = null;
            if (var_3826 == 1) {
                _loc5_ = new Rectangle(0, 0, var_1657.width, var_2203);
            } else {
                _loc5_ = new Rectangle(0, var_1657.height - var_2203, var_1657.width, var_2203);
            }
            param1.copyPixels(var_1657, _loc5_, new Point(0, param3), null, null, true);
        }

        private function getColumnsWidth(param1: Array): int {
            var _loc3_: int = 0;
            var _loc2_: BitmapData = null;
            if (param1 == null || param1.length == 0) {
                return 0;
            }
            var _loc4_: int = 0;
            _loc3_ = 0;
            while (_loc3_ < param1.length) {
                _loc2_ = param1[_loc3_] as BitmapData;
                if (_loc2_ != null) {
                    _loc4_ += _loc2_.width;
                }
                _loc3_++;
            }
            return _loc4_;
        }

        private function renderColumns(param1: BitmapData, param2: Array, param3: int, param4: Boolean): Point {
            var _loc8_: int = 0;
            var _loc5_: int = 0;
            if (param2 == null || param2.length == 0 || param1 == null) {
                return new Point(param3, 0);
            }
            var _loc6_: int = 0;
            var _loc7_: BitmapData = null;
            _loc8_ = 0;
            while (_loc8_ < param2.length) {
                if (param4) {
                    _loc7_ = param2[_loc8_] as BitmapData;
                } else {
                    _loc7_ = param2[param2.length - 1 - _loc8_] as BitmapData;
                }
                if (_loc7_ != null) {
                    if (!param4) {
                        param3 -= _loc7_.width;
                    }
                    _loc5_ = 0;
                    if (var_3826 == 2) {
                        _loc5_ = param1.height - _loc7_.height;
                    }
                    param1.copyPixels(_loc7_, _loc7_.rect, new Point(param3, _loc5_), _loc7_, null, true);
                    if (_loc7_.height > _loc6_) {
                        _loc6_ = _loc7_.height;
                    }
                    if (param4) {
                        param3 += _loc7_.width;
                    }
                    if (param4 && param3 >= param1.width || !param4 && param3 <= 0) {
                        return new Point(param3, _loc6_);
                    }
                }
                _loc8_++;
            }
            return new Point(param3, _loc6_);
        }

        private function renderRepeatAll(param1: BitmapData, param2: Array): int {
            var _loc6_: Point = null;
            if (param2 == null || param2.length == 0 || param1 == null) {
                return 0;
            }
            var _loc4_: int = 0;
            var _loc5_: int = getColumnsWidth(param2);
            var _loc3_: int = 0;
            if (_loc5_ > param1.width) {
            }
            while (_loc3_ < param1.width) {
                _loc3_ = (_loc6_ = renderColumns(param1, param2, _loc3_, true)).x;
                if (_loc6_.y > _loc4_) {
                    _loc4_ = _loc6_.y;
                }
                if (_loc6_.x == 0) {
                    return _loc4_;
                }
            }
            return _loc4_;
        }

        private function renderRepeatBorders(param1: BitmapData, param2: Array): int {
            if (param2 == null || param2.length == 0 || param1 == null) {
                return 0;
            }
            var _loc5_: int = 0;
            var _loc6_: BitmapData = null;
            var _loc9_: Array = [];
            var _loc3_: int = 0;
            var _loc7_: int = 0;
            _loc7_ = 1;
            while (_loc7_ < param2.length - 1) {
                if ((_loc6_ = param2[_loc7_] as BitmapData) != null) {
                    _loc3_ += _loc6_.width;
                    _loc9_.push(_loc6_);
                }
                _loc7_++;
            }
            if (var_2000.length == 1) {
                if ((_loc6_ = var_2000[0] as BitmapData) != null) {
                    _loc3_ = _loc6_.width;
                    _loc9_.push(_loc6_);
                }
            }
            var _loc4_: * = param1.width - _loc3_ >> 1;
            var _loc10_: Point = null;
            var _loc8_: int = (_loc10_ = renderColumns(param1, _loc9_, _loc4_, true)).x;
            if (_loc10_.y > _loc5_) {
                _loc5_ = _loc10_.y;
            }
            if ((_loc6_ = param2[0] as BitmapData) != null) {
                _loc9_ = [_loc6_];
                while (_loc4_ >= 0) {
                    _loc4_ = (_loc10_ = renderColumns(param1, _loc9_, _loc4_, false)).x;
                    if (_loc10_.y > _loc5_) {
                        _loc5_ = _loc10_.y;
                    }
                }
            }
            if ((_loc6_ = param2[param2.length - 1] as BitmapData) != null) {
                _loc9_ = [_loc6_];
                while (_loc8_ < param1.height) {
                    _loc8_ = (_loc10_ = renderColumns(param1, _loc9_, _loc8_, true)).x;
                    if (_loc10_.y > _loc5_) {
                        _loc5_ = _loc10_.y;
                    }
                }
            }
            return _loc5_;
        }

        private function renderRepeatCenter(param1: BitmapData, param2: Array): int {
            var _loc12_: int = 0;
            var _loc11_: int = 0;
            var _loc5_: int = 0;
            var _loc9_: int = 0;
            var _loc15_: Array = null;
            if (param2 == null || param2.length == 0 || param1 == null) {
                return 0;
            }
            var _loc13_: int = 0;
            var _loc8_: BitmapData = null;
            var _loc4_: Array = [];
            var _loc3_: Array = [];
            var _loc18_: int = 0;
            var _loc7_: int = 0;
            var _loc10_: int = 0;
            _loc10_ = 0;
            while (_loc10_ < param2.length >> 1) {
                if ((_loc8_ = param2[_loc10_] as BitmapData) != null) {
                    _loc18_ += _loc8_.width;
                    _loc4_.push(_loc8_);
                }
                _loc10_++;
            }
            _loc10_ = (param2.length >> 1) + 1;
            while (_loc10_ < param2.length) {
                if ((_loc8_ = param2[_loc10_] as BitmapData) != null) {
                    _loc7_ += _loc8_.width;
                    _loc3_.push(_loc8_);
                }
                _loc10_++;
            }
            var _loc16_: Point = null;
            var _loc14_: int = 0;
            var _loc6_: int = 0;
            var _loc17_: int = param1.width;
            if (_loc18_ + _loc7_ > param1.width) {
                _loc14_ = _loc18_ + _loc7_ - param1.width;
                _loc6_ -= _loc14_ >> 1;
                _loc17_ += _loc14_ - (_loc14_ >> 1);
            }
            if (_loc14_ == 0) {
                if ((_loc8_ = param2[param2.length >> 1] as BitmapData) != null) {
                    _loc12_ = _loc8_.width;
                    _loc11_ = param1.width - (_loc18_ + _loc7_);
                    _loc5_ = Math.ceil(_loc11_ / _loc12_) * _loc12_;
                    _loc9_ = (_loc6_ = _loc18_ - (_loc5_ - _loc11_ >> 1)) + _loc5_;
                    _loc15_ = [_loc8_];
                    while (_loc6_ < _loc9_) {
                        _loc6_ = (_loc16_ = renderColumns(param1, _loc15_, _loc6_, true)).x;
                        if (_loc16_.y > _loc13_) {
                            _loc13_ = _loc16_.y;
                        }
                    }
                }
            }
            _loc6_ = 0;
            if ((_loc16_ = renderColumns(param1, _loc4_, _loc6_, true)).y > _loc13_) {
                _loc13_ = _loc16_.y;
            }
            if ((_loc16_ = renderColumns(param1, _loc3_, _loc17_, false)).y > _loc13_) {
                _loc13_ = _loc16_.y;
            }
            return _loc13_;
        }

        private function renderRepeatFirst(param1: BitmapData, param2: Array): int {
            var _loc6_: Array = null;
            if (param2 == null || param2.length == 0 || param1 == null) {
                return 0;
            }
            var _loc4_: int = 0;
            var _loc5_: BitmapData = null;
            var _loc3_: int = param1.width;
            var _loc7_: Point;
            _loc3_ = (_loc7_ = renderColumns(param1, param2, _loc3_, false)).x;
            if (_loc7_.y > _loc4_) {
                _loc4_ = _loc7_.y;
            }
            if ((_loc5_ = param2[0] as BitmapData) != null) {
                _loc6_ = [_loc5_];
                while (_loc3_ >= 0) {
                    _loc3_ = (_loc7_ = renderColumns(param1, _loc6_, _loc3_, false)).x;
                    if (_loc7_.y > _loc4_) {
                        _loc4_ = _loc7_.y;
                    }
                }
            }
            return _loc4_;
        }

        private function renderRepeatLast(param1: BitmapData, param2: Array): int {
            var _loc6_: Array = null;
            if (param2 == null || param2.length == 0 || param1 == null) {
                return 0;
            }
            var _loc4_: int = 0;
            var _loc5_: BitmapData = null;
            var _loc3_: int = 0;
            var _loc7_: Point;
            _loc3_ = (_loc7_ = renderColumns(param1, param2, _loc3_, true)).x;
            if (_loc7_.y > _loc4_) {
                _loc4_ = _loc7_.y;
            }
            if ((_loc5_ = param2[param2.length - 1] as BitmapData) != null) {
                _loc6_ = [_loc5_];
                while (_loc3_ < param1.width) {
                    _loc3_ = (_loc7_ = renderColumns(param1, _loc6_, _loc3_, true)).x;
                    if (_loc7_.y > _loc4_) {
                        _loc4_ = _loc7_.y;
                    }
                }
            }
            return _loc4_;
        }

        private function renderRepeatRandom(param1: BitmapData, param2: Array): int {
            var _loc6_: Array = null;
            var _loc7_: Point = null;
            if (param2 == null || param2.length == 0 || param1 == null) {
                return 0;
            }
            var _loc4_: int = 0;
            var _loc5_: BitmapData = null;
            var _loc3_: int = 0;
            while (_loc3_ < param1.width) {
                if ((_loc5_ = param2[nextRandomColumnIndex(param2.length)] as BitmapData) == null) {
                    return _loc4_;
                }
                _loc6_ = [_loc5_];
                _loc3_ = (_loc7_ = renderColumns(param1, _loc6_, _loc3_, true)).x;
                if (_loc7_.y > _loc4_) {
                    _loc4_ = _loc7_.y;
                }
            }
            return _loc4_;
        }
    }
}
