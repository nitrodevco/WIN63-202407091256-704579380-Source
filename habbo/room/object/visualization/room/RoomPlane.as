package com.sulake.habbo.room.object.visualization.room {
    import assets.class_14

    import com.sulake.core.utils.Map
    import com.sulake.habbo.room.object.visualization.room.mask.PlaneMask
    import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneMaterialCellMatrix
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualizationLayer
    import com.sulake.habbo.room.object.visualization.room.rasterizer.class_3625
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData
    import com.sulake.habbo.room.object.visualization.room.utils.Randomizer
    import com.sulake.habbo.utils.Canvas
    import com.sulake.room.object.visualization.IRoomPlane
    import com.sulake.room.object.visualization.utils.IGraphicAsset
    import com.sulake.room.utils.IRoomGeometry
    import com.sulake.room.utils.IVector3d
    import com.sulake.room.utils.Vector3d

    import flash.display.BitmapData
    import flash.geom.Matrix
    import flash.geom.Point
    import flash.geom.Rectangle

    public class RoomPlane implements IRoomPlane {

        private static const ZERO_POINT: Point = new Point(0, 0);

        public static const const_1150: int = 0;

        public static const const_480: int = 1;

        public static const const_465: int = 2;

        public static const TYPE_LANDSCAPE: int = 3;

        private static var var_4601: int = 1;

        private static function blend(param1: uint, param2: uint): uint {
            return Canvas.colorize(param2, param1 | 4278190080) & 16777215;
        }

        public function RoomPlane(param1: IVector3d, param2: IVector3d, param3: IVector3d, param4: IVector3d, param5: int, param6: Boolean, param7: Array, param8: int, param9: Number = 0, param10: Number = 0, param11: Number = 0, param12: Number = 0) {
            var _loc14_: int = 0;
            var _loc15_: IVector3d = null;
            var _loc13_: Vector3d = null;
            _secondaryNormals = [];
            var_1882 = [];
            var_2037 = [];
            var_2964 = [];
            var_3552 = [];
            super();
            var_4063 = param8;
            _origin = new Vector3d();
            _origin.assign(param1);
            var_501 = new Vector3d();
            var_501.assign(param2);
            var_665 = new Vector3d();
            var_665.assign(param3);
            var_740 = new Vector3d();
            var_740.assign(param4);
            _normal = Vector3d.crossProduct(var_665, var_740);
            if (_normal.length > 0) {
                _normal.mul(1 / _normal.length);
            }
            if (param7 != null) {
                _loc14_ = 0;
                while (_loc14_ < param7.length) {
                    if ((_loc15_ = param7[_loc14_] as IVector3d) != null) {
                        (_loc13_ = new Vector3d()).assign(_loc15_);
                        _secondaryNormals.push(_loc13_);
                    }
                    _loc14_++;
                }
            }
            _offset = new Point();
            var_329 = param5;
            var_1886 = new Map();
            var_1832 = new Vector3d();
            var_1790 = new Vector3d();
            var_1748 = new Vector3d();
            var_1786 = new Vector3d();
            var_4531 = param9;
            var_4636 = param10;
            var_4772 = param11;
            var_4822 = param12;
            var_2881 = param6;
            var_1369 = var_4601++;
        }
        private var _disposed: Boolean = false;
        private var var_4063: int = 0;
        private var _origin: Vector3d = null;
        private var var_501: Vector3d = null;
        private var var_665: Vector3d = null;
        private var var_740: Vector3d = null;
        private var _secondaryNormals: Array;
        private var var_3848: int = -1;
        private var var_329: int = 0;
        private var var_2553: Boolean = false;
        private var var_3824: Boolean = true;
        private var var_2729: class_3625 = null;
        private var var_2665: PlaneMaskManager = null;
        private var var_280: String = null;
        private var var_1369: int = 0;
        private var var_4531: Number = 0;
        private var var_4636: Number = 0;
        private var var_4772: Number = 0;
        private var var_4822: Number = 0;
        private var var_1886: Map = null;
        private var var_1975: PlaneBitmapData = null;
        private var var_2881: Boolean = false;
        private var var_1882: Array;
        private var var_2037: Array;
        private var var_1846: Boolean = false;
        private var var_1688: BitmapData = null;
        private var var_1791: BitmapData = null;
        private var var_2964: Array;
        private var var_3552: Array;
        private var var_1832: Vector3d = null;
        private var var_1790: Vector3d = null;
        private var var_1748: Vector3d = null;
        private var var_1786: Vector3d = null;
        private var _width: Number = 0;
        private var var_46: Number = 0;
        private var var_2842: Boolean = true;
        private var var_4501: Boolean = false;

        private var _normal: Vector3d = null;

        public function get normal(): IVector3d {
            return _normal;
        }

        private var _bitmapData: BitmapData = null;

        public function get bitmapData(): BitmapData {
            var _loc1_: BitmapData = null;
            if (visible) {
                if (_bitmapData != null) {
                    try {
                        _loc1_ = _bitmapData.clone();
                    } catch (e: Error) {
                        return null;
                    }
                }
            }
            return _loc1_;
        }

        private var _offset: Point = null;

        public function get offset(): Point {
            return _offset;
        }

        private var _relativeDepth: Number = 0;

        public function get relativeDepth(): Number {
            return _relativeDepth + _extraDepth;
        }

        private var _color: uint = 0;

        public function get color(): uint {
            return _color;
        }

        public function set color(param1: uint): void {
            _color = param1;
        }

        private var _extraDepth: Number = 0;

        public function set extraDepth(param1: Number): void {
            this._extraDepth = param1;
        }

        public function get canBeVisible(): Boolean {
            return var_2842;
        }

        public function set canBeVisible(param1: Boolean): void {
            if (param1 != var_2842) {
                if (!var_2842) {
                    resetTextureCache();
                }
                var_2842 = param1;
            }
        }

        public function get visible(): Boolean {
            return var_2553 && var_2842;
        }

        public function get type(): int {
            return var_329;
        }

        public function get leftSide(): IVector3d {
            return var_665;
        }

        public function get rightSide(): IVector3d {
            return var_740;
        }

        public function get location(): IVector3d {
            return var_501;
        }

        public function get hasTexture(): Boolean {
            return var_3824;
        }

        public function set hasTexture(param1: Boolean): void {
            var_3824 = param1;
        }

        public function set rasterizer(param1: class_3625): void {
            var_2729 = param1;
        }

        public function set maskManager(param1: PlaneMaskManager): void {
            var_2665 = param1;
        }

        public function set id(param1: String): void {
            if (param1 != var_280) {
                resetTextureCache();
                var_280 = param1;
            }
        }

        public function get uniqueId(): int {
            return var_1369;
        }

        public function get isHighlighter(): Boolean {
            return var_4501;
        }

        public function set isHighlighter(param1: Boolean): void {
            var_4501 = param1;
        }

        public function dispose(): void {
            var _loc2_: int = 0;
            var _loc1_: PlaneBitmapData = null;
            if (_bitmapData != null) {
                _bitmapData.dispose();
                _bitmapData = null;
            }
            if (var_1886 != null) {
                _loc2_ = 0;
                while (_loc2_ < var_1886.length) {
                    _loc1_ = var_1886.getWithIndex(_loc2_) as PlaneBitmapData;
                    if (_loc1_ != null) {
                        if (_loc1_.bitmap != null) {
                            _loc1_.bitmap.dispose();
                        }
                        _loc1_.dispose();
                    }
                    _loc2_++;
                }
                var_1886.dispose();
                var_1886 = null;
            }
            var_1975 = null;
            var_501 = null;
            _origin = null;
            var_665 = null;
            var_740 = null;
            _normal = null;
            var_2729 = null;
            var_1832 = null;
            var_1790 = null;
            var_1748 = null;
            var_1786 = null;
            var_1882 = null;
            var_2037 = null;
            if (var_1688 != null) {
                var_1688.dispose();
                var_1688 = null;
            }
            if (var_1791 != null) {
                var_1791.dispose();
                var_1791 = null;
            }
            _disposed = true;
        }

        public function copyBitmapData(param1: BitmapData): BitmapData {
            if (visible) {
                if (_bitmapData != null && param1 != null) {
                    if (_bitmapData.width == param1.width && _bitmapData.height == param1.height) {
                        param1.copyPixels(_bitmapData, _bitmapData.rect, ZERO_POINT);
                        return param1;
                    }
                }
            }
            return null;
        }

        public function getDrawingDatas(param1: IRoomGeometry): Array {
            var _loc5_: PlaneDrawingData = null;
            var _loc4_: PlaneDrawingData = null;
            var _loc11_: Array = null;
            var _loc10_: PlaneVisualizationLayer = null;
            var _loc7_: int = 0;
            var _loc2_: IVector3d = null;
            var _loc8_: PlaneMaterialCellMatrix = null;
            var _loc3_: Array = null;
            var _loc12_: String = null;
            var _loc13_: Array = [];
            if (var_2553) {
                _loc5_ = null;
                try {
                    _loc5_ = resolveMasks(param1);
                    _loc11_ = var_2729.getLayers(var_280);
                    _loc7_ = 0;
                    while (_loc7_ < _loc11_.length) {
                        if ((_loc10_ = _loc11_[_loc7_] as PlaneVisualizationLayer) != null) {
                            if (var_3824 && _loc10_.getMaterial() != null) {
                                _loc2_ = param1.getCoordinatePosition(_normal);
                                _loc8_ = _loc10_.getMaterial().getMaterialCellMatrix(_loc2_);
                                _loc4_ = new PlaneDrawingData(_loc5_, blend(_color, _loc10_.getColor()), _loc8_.isBottomAligned());
                                Randomizer.setSeed(var_4063);
                                for each(var _loc6_ in _loc8_.getColumns(screenWidth(param1))) {
                                    _loc3_ = [];
                                    for each(var _loc9_ in _loc6_.getCells()) {
                                        if ((_loc12_ = String(_loc9_.getAssetName(_loc2_))) != null) {
                                            _loc3_.push(_loc12_);
                                        }
                                    }
                                    if (_loc3_.length > 0) {
                                        if (!_loc6_.isRepeated()) {
                                            _loc3_.push("");
                                        }
                                        _loc4_.addAssetColumn(_loc3_);
                                    }
                                }
                                if (_loc4_.assetNameColumns.length > 0) {
                                    _loc13_.push(_loc4_);
                                }
                            } else {
                                _loc4_ = new PlaneDrawingData(_loc5_, blend(_color, _loc10_.getColor()));
                                _loc13_.push(_loc4_);
                            }
                        }
                        _loc7_++;
                    }
                } catch (e: Error) {
                    class_14.log("Error in getting RoomPlane drawing data.", e);
                }
                if (_loc13_.length == 0) {
                    _loc13_.push(new PlaneDrawingData(_loc5_, _color));
                }
            }
            return _loc13_;
        }

        public function update(param1: IRoomGeometry, param2: int): Boolean {
            var _loc3_: Number = NaN;
            var _loc8_: int = 0;
            var _loc4_: IVector3d = null;
            var _loc5_: Number = NaN;
            var _loc6_: Number = NaN;
            var _loc7_: BitmapData = null;
            if (param1 == null || _disposed) {
                return false;
            }
            var _loc9_: Boolean = false;
            if (var_3848 != param1.updateId) {
                _loc9_ = true;
            }
            if (!_loc9_ || !var_2842) {
                if (!visible) {
                    return false;
                }
            }
            if (_loc9_) {
                var_1975 = null;
                _loc3_ = 0;
                _loc3_ = Vector3d.cosAngle(param1.directionAxis, normal);
                if (_loc3_ > -0.001) {
                    if (var_2553) {
                        var_2553 = false;
                        return true;
                    }
                    return false;
                }
                _loc8_ = 0;
                while (_loc8_ < _secondaryNormals.length) {
                    _loc3_ = Vector3d.cosAngle(param1.directionAxis, _secondaryNormals[_loc8_]);
                    if (_loc3_ > -0.001) {
                        if (var_2553) {
                            var_2553 = false;
                            return true;
                        }
                        return false;
                    }
                    _loc8_++;
                }
                updateCorners(param1);
                _loc5_ = Number((_loc4_ = param1.getScreenPosition(_origin)).z);
                _loc6_ = Math.max(var_1832.z, var_1790.z, var_1748.z, var_1786.z) - _loc5_;
                if (var_329 == 2) {
                    _loc6_ -= (var_501.z + Math.min(0, var_665.z, var_740.z)) * 8;
                }
                if (var_329 == 3) {
                    _loc6_ += 0.02;
                }
                _relativeDepth = _loc6_;
                var_2553 = true;
                var_3848 = param1.updateId;
            }
            if (_loc9_ || needsNewTexture(param1, param2)) {
                if (_bitmapData == null || _width != _bitmapData.width || var_46 != _bitmapData.height) {
                    if (_bitmapData != null) {
                        _bitmapData.dispose();
                        _bitmapData = null;
                        if (_width < 1 || var_46 < 1) {
                            return true;
                        }
                    } else if (_width < 1 || var_46 < 1) {
                        return false;
                    }
                    try {
                        _bitmapData = new BitmapData(_width, var_46, true, 16777215);
                    } catch (e: Error) {
                        _bitmapData = null;
                        dispose();
                    }
                    if (_bitmapData == null) {
                        return false;
                    }
                    _bitmapData.lock();
                } else {
                    _bitmapData.lock();
                    _bitmapData.fillRect(_bitmapData.rect, 16777215);
                }
                Randomizer.setSeed(var_4063);
                if ((_loc7_ = getTexture(param1, param2)) != null) {
                    renderTexture(param1, _loc7_);
                    _bitmapData.unlock();
                    return _loc7_ || _loc9_;
                }
                dispose();
                return false;
            }
            return false;
        }

        public function resetBitmapMasks(): void {
            if (_disposed) {
                return;
            }
            if (var_2881) {
                if (var_1882.length == 0) {
                    return;
                }
                var_1846 = true;
                var_1882 = [];
            }
        }

        public function addBitmapMask(param1: String, param2: Number, param3: Number): Boolean {
            var _loc5_: RoomPlaneBitmapMask = null;
            var _loc4_: int = 0;
            if (var_2881) {
                _loc5_ = null;
                _loc4_ = 0;
                while (_loc4_ < var_1882.length) {
                    if ((_loc5_ = var_1882[_loc4_] as RoomPlaneBitmapMask) != null) {
                        if (_loc5_.type == param1 && _loc5_.leftSideLoc == param2 && _loc5_.rightSideLoc == param3) {
                            return false;
                        }
                    }
                    _loc4_++;
                }
                _loc5_ = new RoomPlaneBitmapMask(param1, param2, param3);
                var_1882.push(_loc5_);
                var_1846 = true;
                return true;
            }
            return false;
        }

        public function resetRectangleMasks(): void {
            if (var_2881) {
                if (var_2037.length == 0) {
                    return;
                }
                var_1846 = true;
                var_2037 = [];
            }
        }

        public function addRectangleMask(param1: Number, param2: Number, param3: Number, param4: Number): Boolean {
            var _loc6_: RoomPlaneRectangleMask = null;
            var _loc5_: int = 0;
            if (var_2881) {
                _loc6_ = null;
                _loc5_ = 0;
                while (_loc5_ < var_2037.length) {
                    if ((_loc6_ = var_2037[_loc5_] as RoomPlaneRectangleMask) != null) {
                        if (_loc6_.leftSideLoc == param1 && _loc6_.rightSideLoc == param2 && _loc6_.leftSideLength == param3 && _loc6_.rightSideLength == param4) {
                            return false;
                        }
                    }
                    _loc5_++;
                }
                _loc6_ = new RoomPlaneRectangleMask(param1, param2, param3, param4);
                var_2037.push(_loc6_);
                var_1846 = true;
                return true;
            }
            return false;
        }

        private function cacheTexture(param1: String, param2: PlaneBitmapData): Boolean {
            var _loc3_: PlaneBitmapData = var_1886.remove(param1) as PlaneBitmapData;
            if (_loc3_ != null) {
                if (param2 != null && param2.bitmap != _loc3_.bitmap) {
                    _loc3_.bitmap.dispose();
                }
                _loc3_.dispose();
            }
            var_1975 = param2;
            var_1886.add(param1, param2);
            return true;
        }

        private function resetTextureCache(param1: BitmapData = null): void {
            var _loc3_: int = 0;
            var _loc2_: PlaneBitmapData = null;
            if (var_1886 != null) {
                _loc3_ = 0;
                while (_loc3_ < var_1886.length) {
                    _loc2_ = var_1886.getWithIndex(_loc3_) as PlaneBitmapData;
                    if (_loc2_ != null) {
                        if (_loc2_.bitmap != null && _loc2_.bitmap != param1) {
                            _loc2_.bitmap.dispose();
                        }
                        _loc2_.dispose();
                    }
                    _loc3_++;
                }
                var_1886.reset();
            }
            var_1975 = null;
        }

        private function getTextureIdentifier(param1: Number): String {
            if (var_2729 != null) {
                return var_2729.getTextureIdentifier(param1, normal);
            }
            return String(param1);
        }

        private function needsNewTexture(param1: IRoomGeometry, param2: int): Boolean {
            var _loc3_: String = null;
            if (param1 == null) {
                return false;
            }
            var _loc4_: PlaneBitmapData;
            if ((_loc4_ = var_1975) == null) {
                _loc3_ = getTextureIdentifier(param1.scale);
                _loc4_ = var_1886.getValue(_loc3_) as PlaneBitmapData;
            }
            updateMaskChangeStatus();
            if (var_2842 && (_loc4_ == null || _loc4_.timeStamp >= 0 && param2 > _loc4_.timeStamp || var_1846)) {
                return true;
            }
            return false;
        }

        private function getTexture(param1: IRoomGeometry, param2: int): BitmapData {
            var _loc8_: Number = NaN;
            var _loc9_: Number = NaN;
            var _loc4_: IVector3d = null;
            var _loc6_: BitmapData = null;
            var _loc5_: BitmapData = null;
            if (param1 == null) {
                return null;
            }
            var _loc7_: PlaneBitmapData = null;
            var _loc3_: String = null;
            if (needsNewTexture(param1, param2)) {
                _loc8_ = var_665.length * param1.scale;
                _loc9_ = var_740.length * param1.scale;
                _loc4_ = param1.getCoordinatePosition(_normal);
                _loc3_ = getTextureIdentifier(param1.scale);
                if (var_1975 != null) {
                    _loc7_ = var_1975;
                } else {
                    _loc7_ = var_1886.getValue(_loc3_) as PlaneBitmapData;
                }
                _loc6_ = null;
                if (_loc7_ != null) {
                    _loc6_ = _loc7_.bitmap;
                }
                if (var_2729 != null) {
                    if ((_loc7_ = var_2729.render(_loc6_, var_280, _loc8_, _loc9_, param1.scale, _loc4_, var_3824, var_4531, var_4636, var_4772, var_4822, param2)) != null) {
                        if (_loc6_ != null && _loc7_.bitmap != _loc6_) {
                            _loc6_.dispose();
                        }
                    }
                } else {
                    _loc5_ = new BitmapData(_loc8_, _loc9_, true, 4278190080 | _color);
                    _loc7_ = new PlaneBitmapData(_loc5_, -1);
                }
                if (_loc7_ != null) {
                    updateMask(_loc7_.bitmap, param1);
                    cacheTexture(_loc3_, _loc7_);
                }
            } else if (var_1975 != null) {
                _loc7_ = var_1975;
            } else {
                _loc3_ = getTextureIdentifier(param1.scale);
                _loc7_ = var_1886.getValue(_loc3_) as PlaneBitmapData;
            }
            if (_loc7_ != null) {
                var_1975 = _loc7_;
                return _loc7_.bitmap;
            }
            return null;
        }

        private function resolveMasks(param1: IRoomGeometry): PlaneDrawingData {
            var _loc8_: int = 0;
            var _loc10_: PlaneMask = null;
            var _loc5_: String = null;
            var _loc4_: IVector3d = null;
            var _loc11_: IGraphicAsset = null;
            var _loc9_: Point = null;
            if (!var_2881) {
                return null;
            }
            var _loc7_: RoomPlaneBitmapMask = null;
            var _loc2_: int = 0;
            var _loc3_: int = 0;
            var _loc6_: PlaneDrawingData = new PlaneDrawingData();
            _loc8_ = 0;
            while (_loc8_ < var_1882.length) {
                if ((_loc7_ = var_1882[_loc8_] as RoomPlaneBitmapMask) != null) {
                    if ((_loc10_ = var_2665.getMask(_loc7_.type)) != null) {
                        if ((_loc5_ = _loc10_.getAssetName(param1.scale)) != null) {
                            _loc4_ = param1.getCoordinatePosition(_normal);
                            if ((_loc11_ = _loc10_.getGraphicAsset(param1.scale, _loc4_)) != null) {
                                _loc2_ = var_1688.width * (1 - _loc7_.leftSideLoc / var_665.length);
                                _loc3_ = var_1688.height * (1 - _loc7_.rightSideLoc / var_740.length);
                                _loc9_ = new Point(_loc2_ + _loc11_.offsetX, _loc3_ + _loc11_.offsetY);
                                _loc6_.addMask(_loc5_, _loc9_, _loc11_.flipH, _loc11_.flipV);
                            }
                        }
                    }
                }
                _loc8_++;
            }
            return _loc6_;
        }

        private function screenWidth(param1: IRoomGeometry): int {
            var _loc2_: Point = param1.getScreenPoint(new Vector3d(0, 0, 0));
            var _loc3_: Point = param1.getScreenPoint(new Vector3d(0, 1, 0));
            return Math.round(var_665.length * Math.abs(_loc2_.x - _loc3_.x));
        }

        private function addOutlines(param1: PlaneBitmapData): void {
        }

        private function updateCorners(param1: IRoomGeometry): void {
            var_1832.assign(param1.getScreenPosition(var_501));
            var_1790.assign(param1.getScreenPosition(Vector3d.sum(var_501, var_740)));
            var_1748.assign(param1.getScreenPosition(Vector3d.sum(Vector3d.sum(var_501, var_665), var_740)));
            var_1786.assign(param1.getScreenPosition(Vector3d.sum(var_501, var_665)));
            _offset = param1.getScreenPoint(_origin);
            var_1832.x = Math.round(var_1832.x);
            var_1832.y = Math.round(var_1832.y);
            var_1790.x = Math.round(var_1790.x);
            var_1790.y = Math.round(var_1790.y);
            var_1748.x = Math.round(var_1748.x);
            var_1748.y = Math.round(var_1748.y);
            var_1786.x = Math.round(var_1786.x);
            var_1786.y = Math.round(var_1786.y);
            _offset.x = Math.round(_offset.x);
            _offset.y = Math.round(_offset.y);
            var _loc3_: Number = Math.min(var_1832.x, var_1790.x, var_1748.x, var_1786.x);
            var _loc5_: Number = Math.max(var_1832.x, var_1790.x, var_1748.x, var_1786.x);
            var _loc2_: Number = Math.min(var_1832.y, var_1790.y, var_1748.y, var_1786.y);
            var _loc4_: Number = Math.max(var_1832.y, var_1790.y, var_1748.y, var_1786.y);
            _loc5_ -= _loc3_;
            _offset.x -= _loc3_;
            var_1832.x -= _loc3_;
            var_1790.x -= _loc3_;
            var_1748.x -= _loc3_;
            var_1786.x -= _loc3_;
            _loc4_ -= _loc2_;
            _offset.y -= _loc2_;
            var_1832.y -= _loc2_;
            var_1790.y -= _loc2_;
            var_1748.y -= _loc2_;
            var_1786.y -= _loc2_;
            _width = _loc5_;
            var_46 = _loc4_;
        }

        private function renderTexture(param1: IRoomGeometry, param2: BitmapData): void {
            if (var_1832 == null || var_1790 == null || var_1748 == null || var_1786 == null || param2 == null || _bitmapData == null) {
                return;
            }
            var _loc8_: Number = var_1786.x - var_1748.x;
            var _loc10_: Number = var_1786.y - var_1748.y;
            var _loc4_: Number = var_1790.x - var_1748.x;
            var _loc3_: Number = var_1790.y - var_1748.y;
            if (var_329 == 1 || var_329 == 3) {
                if (Math.abs(_loc4_ - param2.width) <= 1) {
                    _loc4_ = param2.width;
                }
                if (Math.abs(_loc3_ - param2.width) <= 1) {
                    _loc3_ = param2.width;
                }
                if (Math.abs(_loc8_ - param2.height) <= 1) {
                    _loc8_ = param2.height;
                }
                if (Math.abs(_loc10_ - param2.height) <= 1) {
                    _loc10_ = param2.height;
                }
            }
            var _loc5_: Number = _loc4_ / param2.width;
            var _loc6_: Number = _loc3_ / param2.width;
            var _loc7_: Number = _loc8_ / param2.height;
            var _loc9_: Number = _loc10_ / param2.height;
            var _loc11_: Matrix;
            (_loc11_ = new Matrix()).a = _loc5_;
            _loc11_.b = _loc6_;
            _loc11_.c = _loc7_;
            _loc11_.d = _loc9_;
            _loc11_.translate(var_1748.x, var_1748.y);
            draw(param2, _loc11_);
        }

        private function draw(param1: BitmapData, param2: Matrix): void {
            var _loc4_: int = 0;
            var _loc7_: * = 0;
            var _loc3_: Number = NaN;
            var _loc6_: int = 0;
            var _loc5_: int = 0;
            if (_bitmapData != null) {
                if (param2.a == 1 && param2.d == 1 && param2.c == 0 && param2.b != 0 && Math.abs(param2.b) <= 1 && (var_329 == 1 || var_329 == 3)) {
                    _loc4_ = 0;
                    _loc7_ = 0;
                    _loc3_ = 0;
                    _loc6_ = 0;
                    if (param2.b > 0) {
                        param2.ty++;
                    }
                    _loc5_ = 0;
                    while (_loc4_ < param1.width) {
                        _loc4_++;
                        _loc3_ += Math.abs(param2.b);
                        if (_loc3_ >= 1) {
                            _bitmapData.copyPixels(param1, new Rectangle(_loc7_ + _loc6_, 0, _loc4_ - _loc7_, param1.height), new Point(param2.tx + _loc7_, param2.ty + _loc5_), null, null, true);
                            _loc7_ = _loc4_;
                            if (param2.b > 0) {
                                _loc5_++;
                            } else {
                                _loc5_--;
                            }
                            _loc3_ = 0;
                        }
                    }
                    if (_loc3_ > 0) {
                        _bitmapData.copyPixels(param1, new Rectangle(_loc7_, 0, _loc4_ - _loc7_, param1.height), new Point(param2.tx + _loc7_, param2.ty + _loc5_), null, null, true);
                    }
                    return;
                }
                _bitmapData.draw(param1, param2, null, null, null, false);
            }
        }

        private function updateMaskChangeStatus(): void {
            var _loc2_: Boolean = false;
            var _loc3_: RoomPlaneBitmapMask = null;
            if (!var_1846) {
                return;
            }
            var _loc4_: int = 0;
            var _loc6_: int = 0;
            var _loc5_: Boolean = true;
            var _loc7_: RoomPlaneBitmapMask = null;
            var _loc1_: RoomPlaneRectangleMask = null;
            if (var_1882.length == var_2964.length) {
                _loc4_;
                while (_loc4_ < var_1882.length) {
                    if ((_loc7_ = var_1882[_loc4_] as RoomPlaneBitmapMask) != null) {
                        _loc2_ = false;
                        _loc6_;
                        while (_loc6_ < var_2964.length) {
                            _loc3_ = var_2964[_loc6_] as RoomPlaneBitmapMask;
                            if (_loc3_ != null) {
                                if (_loc3_.type == _loc7_.type && _loc3_.leftSideLoc == _loc7_.leftSideLoc && _loc3_.rightSideLoc == _loc7_.rightSideLoc) {
                                    _loc2_ = true;
                                    break;
                                }
                            }
                            _loc6_++;
                        }
                        if (!_loc2_) {
                            _loc5_ = false;
                            break;
                        }
                    }
                    _loc4_++;
                }
            } else {
                _loc5_ = false;
            }
            if (var_2037.length > var_3552.length) {
                _loc5_ = false;
            }
            if (_loc5_) {
                var_1846 = false;
            }
        }

        private function updateMask(param1: BitmapData, param2: IRoomGeometry): void {
            var _loc3_: IVector3d = null;
            var _loc10_: int = 0;
            var _loc11_: int = 0;
            var _loc7_: String = null;
            var _loc9_: int = 0;
            var _loc8_: int = 0;
            if (!var_2881 || var_1882.length == 0 && var_2037.length == 0 && !var_1846 || var_2665 == null) {
                return;
            }
            if (param1 == null || param2 == null) {
                return;
            }
            var _loc13_: RoomPlaneBitmapMask = null;
            var _loc4_: RoomPlaneRectangleMask = null;
            var _loc5_: int = 0;
            var _loc6_: int = 0;
            updateMaskChangeStatus();
            var _loc12_: Number = param1.width;
            var _loc14_: Number = param1.height;
            if (var_1688 == null || var_1688.width != _loc12_ || var_1688.height != _loc14_) {
                if (var_1688 != null) {
                    var_1688.dispose();
                    var_1688 = null;
                }
                try {
                    var_1688 = new BitmapData(_loc12_, _loc14_, true, 16777215);
                } catch (e: Error) {
                    var_1688 = null;
                    return;
                }
                var_1846 = true;
            }
            if (var_1846) {
                var_2964 = [];
                var_3552 = [];
                if (var_1688 != null) {
                    var_1688.fillRect(var_1688.rect, 16777215);
                }
                resetTextureCache(param1);
                _loc3_ = param2.getCoordinatePosition(_normal);
                _loc10_ = 0;
                _loc11_ = 0;
                _loc5_ = 0;
                while (_loc5_ < var_1882.length) {
                    if ((_loc13_ = var_1882[_loc5_] as RoomPlaneBitmapMask) != null) {
                        _loc10_ = var_1688.width - var_1688.width * _loc13_.leftSideLoc / var_665.length;
                        _loc11_ = var_1688.height - var_1688.height * _loc13_.rightSideLoc / var_740.length;
                        _loc7_ = _loc13_.type;
                        var_2665.updateMask(var_1688, _loc7_, param2.scale, _loc3_, _loc10_, _loc11_);
                        var_2964.push(new RoomPlaneBitmapMask(_loc7_, _loc13_.leftSideLoc, _loc13_.rightSideLoc));
                    }
                    _loc5_++;
                }
                _loc6_ = 0;
                while (_loc6_ < var_2037.length) {
                    if ((_loc4_ = var_2037[_loc6_] as RoomPlaneRectangleMask) != null) {
                        _loc10_ = var_1688.width - var_1688.width * _loc4_.leftSideLoc / var_665.length;
                        _loc11_ = var_1688.height - var_1688.height * _loc4_.rightSideLoc / var_740.length;
                        _loc9_ = var_1688.width * _loc4_.leftSideLength / var_665.length;
                        _loc8_ = var_1688.height * _loc4_.rightSideLength / var_740.length;
                        var_1688.fillRect(new Rectangle(_loc10_ - _loc9_, _loc11_ - _loc8_, _loc9_, _loc8_), 4278190080);
                        var_3552.push(new RoomPlaneRectangleMask(_loc4_.leftSideLength, _loc4_.rightSideLoc, _loc4_.leftSideLength, _loc4_.rightSideLength));
                    }
                    _loc6_++;
                }
                var_1846 = false;
            }
            combineTextureMask(param1, var_1688);
        }

        private function combineTextureMask(param1: BitmapData, param2: BitmapData): void {
            if (param1 == null || param2 == null) {
                return;
            }
            if (var_1791 != null && (var_1791.width != param1.width || var_1791.height != param1.height)) {
                var_1791.dispose();
                var_1791 = null;
            }
            if (var_1791 == null) {
                try {
                    var_1791 = new BitmapData(param1.width, param1.height, true, 4294967295);
                } catch (e: Error) {
                    if (var_1791) {
                        var_1791.dispose();
                    }
                    var_1791 = null;
                    return;
                }
            }
            var_1791.copyChannel(param1, param1.rect, ZERO_POINT, 8, 1);
            var_1791.draw(param2, null, null, "darken");
            param1.copyChannel(var_1791, var_1791.rect, ZERO_POINT, 1, 8);
        }
    }
}
