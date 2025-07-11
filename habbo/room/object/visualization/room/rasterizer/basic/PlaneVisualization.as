package com.sulake.habbo.room.object.visualization.room.rasterizer.basic {
    import com.sulake.core.runtime.IDisposable
    import com.sulake.habbo.room.object.visualization.room.rasterizer.animated.PlaneVisualizationAnimationLayer
    import com.sulake.room.object.visualization.utils.class_3367
    import com.sulake.room.utils.IRoomGeometry
    import com.sulake.room.utils.IVector3d
    import com.sulake.room.utils.Vector3d

    import flash.display.BitmapData
    import flash.geom.Point

    public class PlaneVisualization {

        public function PlaneVisualization(param1: Number, param2: int, param3: IRoomGeometry) {
            var _loc4_: int = 0;
            _layers = [];
            super();
            if (param2 < 0) {
                param2 = 0;
            }
            _loc4_ = 0;
            while (_loc4_ < param2) {
                _layers.push(null);
                _loc4_++;
            }
            _geometry = param3;
            _cachedBitmapNormal = new Vector3d();
        }
        private var _layers: Array;
        private var var_1657: BitmapData;

        private var _cachedBitmapNormal: Vector3d = null;

        private var var_3602: Boolean = false;

        private var _geometry: IRoomGeometry = null;

        public function get geometry(): IRoomGeometry {
            return _geometry;
        }

        private var _hasAnimationLayers: Boolean = false;

        public function get hasAnimationLayers(): Boolean {
            return _hasAnimationLayers;
        }

        public function dispose(): void {
            var _loc1_: int = 0;
            var _loc2_: IDisposable = null;
            if (_layers != null) {
                _loc1_ = 0;
                while (_loc1_ < _layers.length) {
                    _loc2_ = _layers[_loc1_] as IDisposable;
                    if (_loc2_ != null) {
                        _loc2_.dispose();
                    }
                    _loc1_++;
                }
                _layers = null;
            }
            _geometry = null;
            if (var_1657 != null) {
                var_1657.dispose();
            }
            if (_cachedBitmapNormal != null) {
                _cachedBitmapNormal = null;
            }
        }

        public function clearCache(): void {
            var _loc2_: int = 0;
            var _loc3_: PlaneVisualizationLayer = null;
            var _loc1_: PlaneVisualizationAnimationLayer = null;
            if (!var_3602) {
                return;
            }
            if (var_1657 != null) {
                var_1657.dispose();
                var_1657 = null;
            }
            if (_cachedBitmapNormal != null) {
                _cachedBitmapNormal.assign(new Vector3d());
            }
            if (_layers != null) {
                _loc2_ = 0;
                while (_loc2_ < _layers.length) {
                    _loc3_ = _layers[_loc2_] as PlaneVisualizationLayer;
                    _loc1_ = _layers[_loc2_] as PlaneVisualizationAnimationLayer;
                    if (_loc3_ != null) {
                        _loc3_.clearCache();
                    } else if (_loc1_ != null) {
                        _loc1_.clearCache();
                    }
                    _loc2_++;
                }
            }
            var_3602 = false;
        }

        public function setLayer(param1: int, param2: PlaneMaterial, param3: uint, param4: int, param5: int = 0): Boolean {
            if (param1 < 0 || param1 > _layers.length) {
                return false;
            }
            var _loc6_: IDisposable;
            if ((_loc6_ = _layers[param1] as IDisposable) != null) {
                _loc6_.dispose();
                _loc6_ = null;
            }
            _loc6_ = new PlaneVisualizationLayer(param2, param3, param4, param5);
            _layers[param1] = _loc6_;
            return true;
        }

        public function setAnimationLayer(param1: int, param2: XML, param3: class_3367): Boolean {
            if (param1 < 0 || param1 > _layers.length) {
                return false;
            }
            var _loc4_: IDisposable;
            if ((_loc4_ = _layers[param1] as IDisposable) != null) {
                _loc4_.dispose();
                _loc4_ = null;
            }
            _loc4_ = new PlaneVisualizationAnimationLayer(param2, param3);
            _layers[param1] = _loc4_;
            _hasAnimationLayers = true;
            return true;
        }

        public function getLayers(): Array {
            return _layers;
        }

        public function render(param1: BitmapData, param2: int, param3: int, param4: IVector3d, param5: Boolean, param6: int = 0, param7: int = 0, param8: int = 0, param9: int = 0, param10: Number = 0, param11: Number = 0, param12: int = 0): BitmapData {
            var _loc14_: int = 0;
            var _loc15_: PlaneVisualizationLayer = null;
            var _loc13_: PlaneVisualizationAnimationLayer = null;
            if (param2 < 1) {
                param2 = 1;
            }
            if (param3 < 1) {
                param3 = 1;
            }
            if (param1 == null || param1.width != param2 || param1.height != param3) {
                param1 = null;
            }
            if (var_1657 != null) {
                try {
                    if (var_1657.width == param2 && var_1657.height == param3 && Vector3d.isEqual(_cachedBitmapNormal, param4)) {
                        if (!hasAnimationLayers) {
                            if (param1 != null) {
                                param1.copyPixels(var_1657, var_1657.rect, new Point(0, 0), null, null, false);
                                return param1;
                            }
                            return var_1657;
                        }
                    } else {
                        var_1657.dispose();
                        var_1657 = null;
                    }
                } catch (e: Error) {
                    var_1657.dispose();
                    var_1657 = null;
                    return null;
                }
            }
            var_3602 = true;
            if (var_1657 == null) {
                try {
                    var_1657 = new BitmapData(param2, param3, true, 16777215);
                } catch (e: Error) {
                    if (var_1657) {
                        var_1657.dispose();
                    }
                    var_1657 = null;
                    return null;
                }
            } else {
                var_1657.fillRect(var_1657.rect, 16777215);
            }
            if (param1 == null) {
                param1 = var_1657;
            }
            _cachedBitmapNormal.assign(param4);
            _loc14_ = 0;
            while (_loc14_ < _layers.length) {
                _loc15_ = _layers[_loc14_] as PlaneVisualizationLayer;
                _loc13_ = _layers[_loc14_] as PlaneVisualizationAnimationLayer;
                if (_loc15_ != null) {
                    _loc15_.render(param1, param2, param3, param4, param5, param6, param7);
                } else if (_loc13_ != null) {
                    _loc13_.render(param1, param2, param3, param4, param6, param7, param8, param9, param10, param11, param12);
                }
                _loc14_++;
            }
            if (param1 != null && param1 != var_1657) {
                var_1657.copyPixels(param1, param1.rect, new Point(0, 0), null, null, false);
                return param1;
            }
            return var_1657;
        }
    }
}
