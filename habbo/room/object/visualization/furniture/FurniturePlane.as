package com.sulake.habbo.room.object.visualization.furniture {
    import com.sulake.core.utils.Map
    import com.sulake.room.utils.IRoomGeometry
    import com.sulake.room.utils.IVector3d
    import com.sulake.room.utils.Vector3d

    import flash.display.BitmapData
    import flash.geom.Matrix
    import flash.geom.Point
    import flash.geom.Rectangle

    public class FurniturePlane {

        public function FurniturePlane(param1: IVector3d, param2: IVector3d, param3: IVector3d) {
            super();
            _origin = new Vector3d();
            var_501 = new Vector3d();
            var_501.assign(param1);
            var_665 = new Vector3d();
            var_665.assign(param2);
            var_740 = new Vector3d();
            var_740.assign(param3);
            var_2560 = new Vector3d();
            var_2560.assign(param2);
            var_2593 = new Vector3d();
            var_2593.assign(param3);
            _normal = Vector3d.crossProduct(var_665, var_740);
            if (_normal.length > 0) {
                _normal.mul(1 / _normal.length);
            }
            _offset = new Point();
            var_1832 = new Vector3d();
            var_1790 = new Vector3d();
            var_1748 = new Vector3d();
            var_1786 = new Vector3d();
            var_1886 = new Map();
        }
        private var var_3848: int = -1;
        private var var_3451: Number = 0;
        private var var_4397: Number = 0;
        private var var_4414: Number = 0;
        private var var_3667: Number = 0;
        private var _origin: Vector3d = null;
        private var var_501: Vector3d = null;
        private var var_665: Vector3d = null;
        private var var_740: Vector3d = null;
        private var var_2560: Vector3d = null;
        private var var_2593: Vector3d = null;
        private var var_2553: Boolean = true;
        private var var_1886: Map = null;
        private var var_4808: Boolean = false;
        private var var_280: String = null;
        private var var_1832: Vector3d = null;
        private var var_1790: Vector3d = null;
        private var var_1748: Vector3d = null;
        private var var_1786: Vector3d = null;
        private var _width: Number = 0;
        private var var_46: Number = 0;

        private var _normal: Vector3d = null;

        public function get normal(): IVector3d {
            return _normal;
        }

        private var _bitmapData: BitmapData = null;

        public function get bitmapData(): BitmapData {
            if (var_2553) {
                if (_bitmapData != null) {
                    return _bitmapData.clone();
                }
            }
            return null;
        }

        private var _offset: Point = null;

        public function get offset(): Point {
            return _offset;
        }

        private var _relativeDepth: Number = 0;

        public function get relativeDepth(): Number {
            return _relativeDepth;
        }

        private var _color: uint = 0;

        public function get color(): uint {
            return _color;
        }

        public function set color(param1: uint): void {
            _color = param1;
        }

        public function get visible(): Boolean {
            return var_2553;
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

        public function dispose(): void {
            var _loc2_: int = 0;
            var _loc1_: BitmapData = null;
            if (_bitmapData != null) {
                _bitmapData.dispose();
                _bitmapData = null;
            }
            if (var_1886 != null) {
                _loc2_ = 0;
                while (_loc2_ < var_1886.length) {
                    _loc1_ = var_1886.getWithIndex(_loc2_) as BitmapData;
                    if (_loc1_ != null) {
                        _loc1_.dispose();
                    }
                    _loc2_++;
                }
                var_1886.dispose();
                var_1886 = null;
            }
            _origin = null;
            var_501 = null;
            var_665 = null;
            var_740 = null;
            var_2560 = null;
            var_2593 = null;
            _normal = null;
            var_1832 = null;
            var_1790 = null;
            var_1748 = null;
            var_1786 = null;
        }

        public function setRotation(param1: Boolean): void {
            if (param1 != var_4808) {
                if (!param1) {
                    var_665.assign(var_2560);
                    var_740.assign(var_2593);
                } else {
                    var_665.assign(var_2560);
                    var_665.mul(var_2593.length / var_2560.length);
                    var_740.assign(var_2593);
                    var_740.mul(var_2560.length / var_2593.length);
                }
                var_3848 = -1;
                var_3451 -= 1;
                var_4808 = param1;
                resetTextureCache();
            }
        }

        public function update(param1: IRoomGeometry, param2: int): Boolean {
            var _loc6_: IVector3d = null;
            var _loc3_: Number = NaN;
            var _loc4_: IVector3d = null;
            var _loc5_: Number = NaN;
            var _loc7_: Number = NaN;
            var _loc8_: BitmapData = null;
            if (param1 == null || var_501 == null && _origin != null || var_665 == null || var_740 == null || _normal == null) {
                return false;
            }
            var _loc9_: Boolean = false;
            if (param1.updateId != var_3848) {
                var_3848 = param1.updateId;
                if ((_loc6_ = param1.direction) != null && (_loc6_.x != var_3451 || _loc6_.y != var_4397 || _loc6_.z != var_4414 || param1.scale != var_3667)) {
                    var_3451 = _loc6_.x;
                    var_4397 = _loc6_.y;
                    var_4414 = _loc6_.z;
                    var_3667 = param1.scale;
                    _loc9_ = true;
                    _loc3_ = 0;
                    _loc3_ = Vector3d.cosAngle(param1.directionAxis, normal);
                    if (_loc3_ > -0.001) {
                        if (var_2553) {
                            var_2553 = false;
                            return true;
                        }
                        return false;
                    }
                    updateCorners(param1);
                    _loc5_ = Number((_loc4_ = param1.getScreenPosition(_origin)).z);
                    _relativeDepth = _loc7_ = Math.max(var_1832.z - _loc5_, var_1790.z - _loc5_, var_1748.z - _loc5_, var_1786.z - _loc5_);
                    var_2553 = true;
                }
            }
            if (needsNewTexture(param1) || _loc9_) {
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
                    _bitmapData = new BitmapData(_width, var_46, true, 16777215);
                    _bitmapData.lock();
                } else {
                    _bitmapData.lock();
                    _bitmapData.fillRect(_bitmapData.rect, 16777215);
                }
                if ((_loc8_ = getTexture(param1, param2)) != null) {
                    renderTexture(param1, _loc8_);
                }
                _bitmapData.unlock();
                return true;
            }
            return false;
        }

        private function cacheTexture(param1: String, param2: BitmapData): Boolean {
            var _loc3_: BitmapData = var_1886.remove(param1) as BitmapData;
            if (_loc3_ != null && param2 != _loc3_) {
                _loc3_.dispose();
            }
            var_1886.add(param1, param2);
            return true;
        }

        private function resetTextureCache(): void {
            var _loc2_: int = 0;
            var _loc1_: BitmapData = null;
            if (var_1886 != null) {
                _loc2_ = 0;
                while (_loc2_ < var_1886.length) {
                    _loc1_ = var_1886.getWithIndex(_loc2_) as BitmapData;
                    if (_loc1_ != null) {
                        _loc1_.dispose();
                    }
                    _loc2_++;
                }
                var_1886.reset();
            }
        }

        private function getTextureIdentifier(param1: IRoomGeometry): String {
            if (param1 == null) {
                return null;
            }
            return String(param1.scale);
        }

        private function needsNewTexture(param1: IRoomGeometry): Boolean {
            if (param1 == null) {
                return false;
            }
            var _loc2_: String = getTextureIdentifier(param1);
            var _loc3_: BitmapData = var_1886.getValue(_loc2_) as BitmapData;
            if (_width > 0 && var_46 > 0) {
                if (_loc3_ == null) {
                    return true;
                }
            }
            return false;
        }

        private function getTexture(param1: IRoomGeometry, param2: int): BitmapData {
            var _loc6_: Number = NaN;
            var _loc7_: Number = NaN;
            var _loc4_: IVector3d = null;
            if (param1 == null) {
                return null;
            }
            var _loc3_: String = getTextureIdentifier(param1);
            var _loc5_: BitmapData = null;
            if (needsNewTexture(param1)) {
                _loc6_ = var_665.length * param1.scale;
                _loc7_ = var_740.length * param1.scale;
                if (_loc6_ < 1) {
                    _loc6_ = 1;
                }
                if (_loc7_ < 1) {
                    _loc7_ = 1;
                }
                _loc4_ = param1.getCoordinatePosition(_normal);
                if ((_loc5_ = var_1886.getValue(_loc3_) as BitmapData) == null) {
                    if ((_loc5_ = new BitmapData(_loc6_, _loc7_, true, 4278190080 | _color)) != null) {
                        cacheTexture(_loc3_, _loc5_);
                    }
                }
            } else {
                _loc5_ = var_1886.getValue(_loc3_) as BitmapData;
            }
            if (_loc5_ != null) {
                return _loc5_;
            }
            return null;
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
                if (param2.a == 1 && param2.d == 1 && param2.c == 0 && param2.b != 0 && Math.abs(param2.b) <= 1) {
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
    }
}
