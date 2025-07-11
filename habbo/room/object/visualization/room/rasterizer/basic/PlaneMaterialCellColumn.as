package com.sulake.habbo.room.object.visualization.room.rasterizer.basic {
    import com.sulake.room.utils.IVector3d
    import com.sulake.room.utils.Vector3d

    import flash.display.BitmapData
    import flash.geom.Point

    public class PlaneMaterialCellColumn {

        public static const REPEAT_MODE_NONE: int = 0;

        public static const REPEAT_MODE_ALL: int = 1;

        public static const REPEAT_MODE_BORDERS: int = 2;

        public static const REPEAT_MODE_CENTER: int = 3;

        public static const REPEAT_MODE_FIRST: int = 4;

        public static const REPEAT_MODE_LAST: int = 5;

        public function PlaneMaterialCellColumn(param1: int, param2: Array, param3: int = 1) {
            var _loc4_: int = 0;
            var _loc5_: PlaneMaterialCell = null;
            _cells = [];
            super();
            if (param1 < 1) {
                param1 = 1;
            }
            _width = param1;
            if (param2 != null) {
                _loc4_ = 0;
                while (_loc4_ < param2.length) {
                    if ((_loc5_ = param2[_loc4_] as PlaneMaterialCell) != null) {
                        _cells.push(_loc5_);
                        if (!_loc5_.isStatic) {
                            var_3639 = false;
                        }
                    }
                    _loc4_++;
                }
            }
            var_3706 = param3;
        }
        private var _cells: Array;
        private var var_3706: int = 1;
        private var var_1657: BitmapData;

        private var _cachedBitmapNormal: Vector3d = null;

        private var var_4765: int;

        private var var_4821: int;

        private var var_3602: Boolean = false;

        private var var_3639: Boolean = true;

        private var _width: int = 1;

        public function get width(): int {
            return _width;
        }

        public function get isStatic(): Boolean {
            return var_3639;
        }

        public function isRepeated(): Boolean {
            return var_3706 != 0;
        }

        public function dispose(): void {
            var _loc1_: int = 0;
            var _loc2_: PlaneMaterialCell = null;
            if (_cells != null) {
                _loc1_ = 0;
                while (_loc1_ < _cells.length) {
                    _loc2_ = _cells[_loc1_] as PlaneMaterialCell;
                    if (_loc2_ != null) {
                        _loc2_.dispose();
                    }
                    _loc1_++;
                }
                _cells = null;
            }
            if (var_1657 != null) {
                var_1657.dispose();
                var_1657 = null;
            }
            if (_cachedBitmapNormal != null) {
                _cachedBitmapNormal = null;
            }
        }

        public function clearCache(): void {
            var _loc1_: int = 0;
            var _loc2_: PlaneMaterialCell = null;
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
            if (_cells != null) {
                _loc1_ = 0;
                while (_loc1_ < _cells.length) {
                    _loc2_ = _cells[_loc1_] as PlaneMaterialCell;
                    if (_loc2_ != null) {
                        _loc2_.clearCache();
                    }
                    _loc1_++;
                }
            }
            var_3602 = false;
        }

        public function render(param1: int, param2: IVector3d, param3: int, param4: int): BitmapData {
            var _loc5_: int = 0;
            if (var_3706 == 0) {
                param1 = _loc5_ = getCellsHeight(_cells, param2);
            }
            if (_cachedBitmapNormal == null) {
                _cachedBitmapNormal = new Vector3d();
            }
            if (isStatic) {
                if (var_1657 != null) {
                    if (var_1657.height == param1 && Vector3d.isEqual(_cachedBitmapNormal, param2) && var_4765 == param3 && var_4821 == param4) {
                        return var_1657;
                    }
                    var_1657.dispose();
                    var_1657 = null;
                }
            } else if (var_1657 != null) {
                if (var_1657.height == param1) {
                    var_1657.fillRect(var_1657.rect, 16777215);
                } else {
                    var_1657.dispose();
                    var_1657 = null;
                }
            }
            var_3602 = true;
            if (var_1657 == null) {
                try {
                    var_1657 = new BitmapData(_width, param1, true, 16777215);
                } catch (e: Error) {
                    return null;
                }
            }
            _cachedBitmapNormal.assign(param2);
            var_4765 = param3;
            var_4821 = param4;
            if (_cells.length == 0) {
                return var_1657;
            }
            switch (var_3706) {
                case 0:
                    renderRepeatNone(param2);
                    break;
                case 2:
                    renderRepeatBorders(param2);
                    break;
                case 3:
                    renderRepeatCenter(param2);
                    break;
                case 4:
                    renderRepeatFirst(param2);
                    break;
                case 5:
                    renderRepeatLast(param2);
                    break;
                default:
                    renderRepeatAll(param2, param3, param4);
            }
            return var_1657;
        }

        public function getCells(): Array {
            return _cells;
        }

        private function getCellsHeight(param1: Array, param2: IVector3d): int {
            var _loc3_: int = 0;
            var _loc5_: PlaneMaterialCell = null;
            var _loc6_: int = 0;
            if (param1 == null || param1.length == 0) {
                return 0;
            }
            var _loc4_: int = 0;
            _loc3_ = 0;
            while (_loc3_ < param1.length) {
                if ((_loc5_ = param1[_loc3_] as PlaneMaterialCell) != null) {
                    _loc6_ = _loc5_.getHeight(param2);
                    _loc4_ += _loc6_;
                }
                _loc3_++;
            }
            return _loc4_;
        }

        private function renderCells(param1: Array, param2: int, param3: Boolean, param4: IVector3d, param5: int = 0, param6: int = 0): int {
            var _loc8_: int = 0;
            if (param1 == null || param1.length == 0 || var_1657 == null) {
                return param2;
            }
            var _loc9_: PlaneMaterialCell = null;
            var _loc7_: BitmapData = null;
            _loc8_ = 0;
            while (_loc8_ < param1.length) {
                if (param3) {
                    _loc9_ = param1[_loc8_] as PlaneMaterialCell;
                } else {
                    _loc9_ = param1[param1.length - 1 - _loc8_] as PlaneMaterialCell;
                }
                if (_loc9_ != null) {
                    if ((_loc7_ = _loc9_.render(param4, param5, param6)) != null) {
                        if (!param3) {
                            param2 -= _loc7_.height;
                        }
                        var_1657.copyPixels(_loc7_, _loc7_.rect, new Point(0, param2), _loc7_, null, true);
                        if (param3) {
                            param2 += _loc7_.height;
                        }
                        if (param3 && param2 >= var_1657.height || !param3 && param2 <= 0) {
                            return param2;
                        }
                    }
                }
                _loc8_++;
            }
            return param2;
        }

        private function renderRepeatNone(param1: IVector3d): void {
            if (_cells.length == 0 || var_1657 == null) {
                return;
            }
            renderCells(_cells, 0, true, param1);
        }

        private function renderRepeatAll(param1: IVector3d, param2: int, param3: int): void {
            if (_cells.length == 0 || var_1657 == null) {
                return;
            }
            var _loc5_: int = getCellsHeight(_cells, param1);
            var _loc4_: int = 0;
            if (_loc5_ > var_1657.height) {
            }
            while (_loc4_ < var_1657.height) {
                if ((_loc4_ = renderCells(_cells, _loc4_, true, param1, param2, param3)) == 0) {
                    return;
                }
            }
        }

        private function renderRepeatBorders(param1: IVector3d): void {
            if (_cells.length == 0 || var_1657 == null) {
                return;
            }
            var _loc8_: PlaneMaterialCell = null;
            var _loc5_: BitmapData = null;
            var _loc3_: Array = [];
            var _loc2_: int = 0;
            var _loc9_: int = 0;
            var _loc6_: int = 0;
            _loc6_ = 1;
            while (_loc6_ < _cells.length - 1) {
                if ((_loc8_ = _cells[_loc6_] as PlaneMaterialCell) != null) {
                    if ((_loc9_ = _loc8_.getHeight(param1)) > 0) {
                        _loc2_ += _loc9_;
                        _loc3_.push(_loc8_);
                    }
                }
                _loc6_++;
            }
            if (_cells.length == 1) {
                if ((_loc8_ = _cells[0] as PlaneMaterialCell) != null) {
                    if ((_loc9_ = _loc8_.getHeight(param1)) > 0) {
                        _loc2_ += _loc9_;
                        _loc3_.push(_loc8_);
                    }
                }
            }
            var _loc4_: * = var_1657.height - _loc2_ >> 1;
            var _loc7_: int = renderCells(_loc3_, _loc4_, true, param1);
            if ((_loc8_ = _cells[0] as PlaneMaterialCell) != null) {
                _loc3_ = [_loc8_];
                while (_loc4_ >= 0) {
                    _loc4_ = renderCells(_loc3_, _loc4_, false, param1);
                }
            }
            if ((_loc8_ = _cells[_cells.length - 1] as PlaneMaterialCell) != null) {
                _loc3_ = [_loc8_];
                while (_loc7_ < var_1657.height) {
                    _loc7_ = renderCells(_loc3_, _loc7_, true, param1);
                }
            }
        }

        private function renderRepeatCenter(param1: IVector3d): void {
            var _loc7_: int = 0;
            var _loc6_: int = 0;
            var _loc3_: int = 0;
            var _loc8_: Array = null;
            if (_cells.length == 0 || var_1657 == null) {
                return;
            }
            var _loc5_: PlaneMaterialCell = null;
            var _loc9_: BitmapData = null;
            var _loc11_: Array = [];
            var _loc14_: Array = [];
            var _loc10_: int = 0;
            var _loc12_: int = 0;
            var _loc16_: int = 0;
            var _loc4_: int = 0;
            _loc4_ = 0;
            while (_loc4_ < _cells.length >> 1) {
                if ((_loc5_ = _cells[_loc4_] as PlaneMaterialCell) != null) {
                    if ((_loc16_ = _loc5_.getHeight(param1)) > 0) {
                        _loc10_ += _loc16_;
                        _loc11_.push(_loc5_);
                    }
                }
                _loc4_++;
            }
            _loc4_ = (_cells.length >> 1) + 1;
            while (_loc4_ < _cells.length) {
                if ((_loc5_ = _cells[_loc4_] as PlaneMaterialCell) != null) {
                    if ((_loc16_ = _loc5_.getHeight(param1)) > 0) {
                        _loc12_ += _loc16_;
                        _loc14_.push(_loc5_);
                    }
                }
                _loc4_++;
            }
            var _loc13_: int = 0;
            var _loc2_: int = 0;
            var _loc15_: int = var_1657.height;
            if (_loc10_ + _loc12_ > var_1657.height) {
                _loc13_ = _loc10_ + _loc12_ - var_1657.height;
                _loc2_ -= _loc13_ >> 1;
                _loc15_ += _loc13_ - (_loc13_ >> 1);
            }
            if (_loc13_ == 0) {
                if ((_loc5_ = _cells[_cells.length >> 1] as PlaneMaterialCell) != null) {
                    if ((_loc16_ = _loc5_.getHeight(param1)) > 0) {
                        _loc7_ = var_1657.height - (_loc10_ + _loc12_);
                        _loc6_ = Math.ceil(_loc7_ / _loc16_) * _loc16_;
                        _loc2_ = _loc10_ - (_loc6_ - _loc7_ >> 1);
                        _loc3_ = _loc2_ + _loc6_;
                        _loc8_ = [_loc5_];
                        while (_loc2_ < _loc3_) {
                            _loc2_ = renderCells(_loc8_, _loc2_, true, param1);
                        }
                    }
                }
            }
            _loc2_ = 0;
            renderCells(_loc11_, _loc2_, true, param1);
            renderCells(_loc14_, _loc15_, false, param1);
        }

        private function renderRepeatFirst(param1: IVector3d): void {
            var _loc2_: Array = null;
            if (_cells.length == 0 || var_1657 == null) {
                return;
            }
            var _loc4_: PlaneMaterialCell = null;
            var _loc3_: int = var_1657.height;
            _loc3_ = renderCells(_cells, _loc3_, false, param1);
            if ((_loc4_ = _cells[0] as PlaneMaterialCell) != null) {
                _loc2_ = [_loc4_];
                while (_loc3_ >= 0) {
                    _loc3_ = renderCells(_loc2_, _loc3_, false, param1);
                }
            }
        }

        private function renderRepeatLast(param1: IVector3d): void {
            var _loc2_: Array = null;
            if (_cells.length == 0 || var_1657 == null) {
                return;
            }
            var _loc4_: PlaneMaterialCell = null;
            var _loc3_: int = 0;
            _loc3_ = renderCells(_cells, _loc3_, true, param1);
            if ((_loc4_ = _cells[_cells.length - 1] as PlaneMaterialCell) != null) {
                _loc2_ = [_loc4_];
                while (_loc3_ < var_1657.height) {
                    _loc3_ = renderCells(_loc2_, _loc3_, true, param1);
                }
            }
        }
    }
}
