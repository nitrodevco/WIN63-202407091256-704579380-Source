package com.sulake.habbo.room.object.visualization.data {
    import com.sulake.core.utils.Map
    import com.sulake.room.utils.class_1781

    public class SizeData {

        public static const LAYER_LIMIT: int = 1000;

        public static const DEFAULT_DIRECTION: int = 0;

        public function SizeData(param1: int, param2: int) {
            super();
            if (param1 < 0) {
                param1 = 0;
            }
            if (param1 > 1000) {
                param1 = 1000;
            }
            var_2448 = param1;
            if (param2 < 1) {
                param2 = 1;
            }
            if (param2 > 360) {
                param2 = 360;
            }
            var_3653 = param2;
            var_2561 = new DirectionData(param1);
            _directions = new Map();
            _colors = new Map();
        }
        private var var_2448: int = 0;
        private var var_3653: int = 360;
        private var var_2561: DirectionData = null;
        private var _directions: Map;
        private var _colors: Map;
        private var var_2680: DirectionData = null;
        private var var_3764: int = -1;

        public function get layerCount(): int {
            return var_2448;
        }

        public function dispose(): void {
            var _loc3_: DirectionData = null;
            var _loc1_: ColorData = null;
            if (var_2561 != null) {
                var_2561.dispose();
                var_2561 = null;
            }
            var _loc2_: int = 0;
            if (_directions != null) {
                _loc3_ = null;
                _loc2_ = 0;
                while (_loc2_ < _directions.length) {
                    _loc3_ = _directions.getWithIndex(_loc2_) as DirectionData;
                    if (_loc3_ != null) {
                        _loc3_.dispose();
                    }
                    _loc2_++;
                }
                _directions.dispose();
                _directions = null;
            }
            var_2680 = null;
            if (_colors != null) {
                _loc1_ = null;
                _loc2_ = 0;
                while (_loc2_ < _colors.length) {
                    _loc1_ = _colors.getWithIndex(_loc2_) as ColorData;
                    if (_loc1_ != null) {
                        _loc1_.dispose();
                    }
                    _loc2_++;
                }
                _colors.dispose();
                _colors = null;
            }
        }

        public function defineLayers(param1: XML): Boolean {
            if (param1 == null) {
                return false;
            }
            var _loc2_: XMLList = param1.layer;
            return defineDirection(var_2561, _loc2_);
        }

        public function defineDirections(param1: XML): Boolean {
            var _loc3_: int = 0;
            var _loc8_: XML = null;
            var _loc7_: int = 0;
            var _loc4_: XMLList = null;
            if (param1 == null) {
                return false;
            }
            var _loc2_: Array = ["id"];
            var _loc5_: DirectionData = null;
            var _loc6_: XMLList = param1.direction;
            _loc3_ = 0;
            while (_loc3_ < _loc6_.length()) {
                _loc8_ = _loc6_[_loc3_];
                if (!class_1781.checkRequiredAttributes(_loc8_, _loc2_)) {
                    return false;
                }
                _loc7_ = int(_loc8_.@id);
                _loc4_ = _loc8_.layer;
                if (_directions.getValue(String(_loc7_)) != null) {
                    return false;
                }
                (_loc5_ = new DirectionData(layerCount)).copyValues(var_2561);
                defineDirection(_loc5_, _loc4_);
                _directions.add(String(_loc7_), _loc5_);
                var_3764 = -1;
                var_2680 = null;
                _loc3_++;
            }
            return true;
        }

        public function defineColors(param1: XML): Boolean {
            var _loc6_: int = 0;
            var _loc3_: XML = null;
            var _loc13_: String = null;
            var _loc10_: XMLList = null;
            var _loc7_: int = 0;
            var _loc4_: XML = null;
            var _loc9_: int = 0;
            var _loc12_: int = 0;
            if (param1 == null) {
                return true;
            }
            var _loc5_: ColorData = null;
            var _loc11_: Array = ["id"];
            var _loc2_: Array = ["id", "color"];
            var _loc8_: XMLList = param1.color;
            _loc6_ = 0;
            while (_loc6_ < _loc8_.length()) {
                _loc3_ = _loc8_[_loc6_];
                if (!class_1781.checkRequiredAttributes(_loc3_, _loc11_)) {
                    return false;
                }
                _loc13_ = _loc3_.@id;
                if (_colors.getValue(_loc13_) != null) {
                    return false;
                }
                _loc5_ = new ColorData(layerCount);
                _loc10_ = _loc3_.colorLayer;
                _loc7_ = 0;
                while (_loc7_ < _loc10_.length()) {
                    _loc4_ = _loc10_[_loc7_];
                    if (!class_1781.checkRequiredAttributes(_loc4_, _loc2_)) {
                        _loc5_.dispose();
                        return false;
                    }
                    _loc9_ = int(_loc4_.@id);
                    _loc12_ = parseInt(_loc4_.@color, 16);
                    _loc5_.setColor(_loc12_, _loc9_);
                    _loc7_++;
                }
                if (_loc5_ != null) {
                    _colors.add(_loc13_, _loc5_);
                }
                _loc6_++;
            }
            return true;
        }

        public function getDirectionValue(param1: int): int {
            var _loc4_: int = 0;
            var _loc5_: int = 0;
            var _loc2_: int = 0;
            var _loc6_: int = (param1 % 360 + 360 + var_3653 / 2) % 360 / var_3653;
            if (_directions.getValue(String(_loc6_)) != null) {
                return _loc6_;
            }
            _loc6_ = (param1 % 360 + 360) % 360;
            var _loc7_: * = -1;
            var _loc3_: * = -1;
            _loc4_ = 0;
            while (_loc4_ < _directions.length) {
                _loc2_ = ((_loc5_ = _directions.getKey(_loc4_) * var_3653) - _loc6_ + 360) % 360;
                if (_loc2_ > 180) {
                    _loc2_ = 360 - _loc2_;
                }
                if (_loc2_ < _loc7_ || _loc7_ < 0) {
                    _loc7_ = _loc2_;
                    _loc3_ = _loc4_;
                }
                _loc4_++;
            }
            if (_loc3_ >= 0) {
                return _directions.getKey(_loc3_);
            }
            return 0;
        }

        public function getTag(param1: int, param2: int): String {
            var _loc3_: DirectionData = null;
            _loc3_ = getDirectionData(param1);
            if (_loc3_ != null) {
                return _loc3_.getTag(param2);
            }
            return "";
        }

        public function getInk(param1: int, param2: int): int {
            var _loc3_: DirectionData = null;
            _loc3_ = getDirectionData(param1);
            if (_loc3_ != null) {
                return _loc3_.getInk(param2);
            }
            return 0;
        }

        public function getAlpha(param1: int, param2: int): int {
            var _loc3_: DirectionData = null;
            _loc3_ = getDirectionData(param1);
            if (_loc3_ != null) {
                return _loc3_.getAlpha(param2);
            }
            return 255;
        }

        public function getColor(param1: int, param2: int): uint {
            var _loc3_: ColorData = _colors.getValue(String(param2)) as ColorData;
            if (_loc3_ != null) {
                return _loc3_.getColor(param1);
            }
            return 16777215;
        }

        public function getIgnoreMouse(param1: int, param2: int): Boolean {
            var _loc3_: DirectionData = null;
            _loc3_ = getDirectionData(param1);
            if (_loc3_ != null) {
                return _loc3_.getIgnoreMouse(param2);
            }
            return false;
        }

        public function getXOffset(param1: int, param2: int): int {
            var _loc3_: DirectionData = null;
            _loc3_ = getDirectionData(param1);
            if (_loc3_ != null) {
                return _loc3_.getXOffset(param2);
            }
            return 0;
        }

        public function getYOffset(param1: int, param2: int): int {
            var _loc3_: DirectionData = null;
            _loc3_ = getDirectionData(param1);
            if (_loc3_ != null) {
                return _loc3_.getYOffset(param2);
            }
            return 0;
        }

        public function getZOffset(param1: int, param2: int): Number {
            var _loc3_: DirectionData = null;
            _loc3_ = getDirectionData(param1);
            if (_loc3_ != null) {
                return _loc3_.getZOffset(param2);
            }
            return 0;
        }

        private function defineDirection(param1: DirectionData, param2: XMLList): Boolean {
            var _loc5_: int = 0;
            var _loc10_: XML = null;
            var _loc7_: int = 0;
            var _loc8_: String = null;
            var _loc4_: String = null;
            var _loc3_: int = 0;
            var _loc6_: int = 0;
            if (param1 == null || param2 == null) {
                return false;
            }
            var _loc9_: Array = ["id"];
            _loc5_ = 0;
            while (_loc5_ < param2.length()) {
                _loc10_ = param2[_loc5_];
                if (!class_1781.checkRequiredAttributes(_loc10_, _loc9_)) {
                    return false;
                }
                if ((_loc7_ = int(_loc10_.@id)) < 0 || _loc7_ >= layerCount) {
                    return false;
                }
                if ((_loc8_ = _loc10_.@tag).length > 0) {
                    param1.setTag(_loc7_, _loc8_);
                }
                switch (_loc4_ = _loc10_.@ink) {
                    case "ADD":
                        param1.setInk(_loc7_, 1);
                        break;
                    case "SUBTRACT":
                        param1.setInk(_loc7_, 2);
                        break;
                    case "DARKEN":
                        param1.setInk(_loc7_, 3);
                        break;
                    case "DIFFERENCE":
                        param1.setInk(_loc7_, 4);
                        break;
                    case "MULTIPLY":
                        param1.setInk(_loc7_, 5);
                        break;
                    case "INVERT":
                        param1.setInk(_loc7_, 6);
                        break;
                    case "SCREEN":
                        param1.setInk(_loc7_, 7);
                }
                if ((_loc8_ = _loc10_.@alpha).length > 0) {
                    param1.setAlpha(_loc7_, int(_loc8_));
                }
                if ((_loc8_ = _loc10_.@ignoreMouse).length > 0) {
                    _loc3_ = int(_loc8_);
                    param1.setIgnoreMouse(_loc7_, _loc3_ != 0);
                }
                if ((_loc8_ = _loc10_.@x).length > 0) {
                    param1.setXOffset(_loc7_, int(_loc8_));
                }
                if ((_loc8_ = _loc10_.@y).length > 0) {
                    param1.setYOffset(_loc7_, int(_loc8_));
                }
                if ((_loc8_ = _loc10_.@z).length > 0) {
                    _loc6_ = int(_loc8_);
                    param1.setZOffset(_loc7_, _loc6_ / -1000);
                }
                _loc5_++;
            }
            return true;
        }

        private function getDirectionData(param1: int): DirectionData {
            if (param1 == var_3764 && var_2680 != null) {
                return var_2680;
            }
            var _loc2_: DirectionData = null;
            _loc2_ = _directions.getValue(String(param1)) as DirectionData;
            if (_loc2_ == null) {
                _loc2_ = var_2561;
            }
            var_3764 = param1;
            var_2680 = _loc2_;
            return var_2680;
        }
    }
}
