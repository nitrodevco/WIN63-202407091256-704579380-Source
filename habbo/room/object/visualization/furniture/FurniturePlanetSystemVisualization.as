package com.sulake.habbo.room.object.visualization.furniture {
    import com.sulake.room.object.IRoomObject
    import com.sulake.room.object.IRoomObjectModel
    import com.sulake.room.object.visualization.IRoomObjectSprite
    import com.sulake.room.utils.Vector3d

    public class FurniturePlanetSystemVisualization extends AnimatedFurnitureVisualization {

        public function FurniturePlanetSystemVisualization() {
            _offsetArray = [];
            var_4554 = new Vector3d(0, 0, 0);
            super();
        }
        private var var_2016: Array;
        private var var_3815: Array;
        private var _offsetArray: Array;
        private var var_4554: Vector3d;

        override public function dispose(): void {
            var _loc1_: FurniturePlanetSystemVisualizationPlanetObject = null;
            if (var_2016 != null) {
                while (var_2016.length > 0) {
                    _loc1_ = var_2016.shift();
                    _loc1_.dispose();
                }
            }
            var_2016 = null;
            var_3815 = null;
        }

        override protected function updateAnimation(param1: Number): int {
            var _loc2_: FurniturePlanetSystemVisualizationPlanetObject = null;
            var _loc3_: int = 0;
            if (var_2016 == null && spriteCount > 0) {
                if (!readDefinition()) {
                    return 0;
                }
            }
            if (var_2016 != null) {
                _loc3_ = 0;
                while (_loc3_ < var_2016.length) {
                    _loc2_ = var_2016[_loc3_];
                    _loc2_.update(_offsetArray, var_4554, param1);
                    _loc3_++;
                }
                return super.updateAnimation(param1);
            }
            return 0;
        }

        override protected function getSpriteXOffset(param1: int, param2: int, param3: int): int {
            if (param3 < _offsetArray.length) {
                return _offsetArray[param3].x;
            }
            return super.getSpriteXOffset(param1, param2, param3);
        }

        override protected function getSpriteYOffset(param1: int, param2: int, param3: int): int {
            if (param3 < _offsetArray.length) {
                return _offsetArray[param3].y;
            }
            return super.getSpriteYOffset(param1, param2, param3);
        }

        override protected function getSpriteZOffset(param1: int, param2: int, param3: int): Number {
            if (param3 < _offsetArray.length) {
                return _offsetArray[param3].z;
            }
            return super.getSpriteZOffset(param1, param2, param3);
        }

        private function readDefinition(): Boolean {
            var _loc4_: IRoomObjectSprite = null;
            var _loc5_: int = 0;
            var _loc9_: XML = null;
            var _loc2_: IRoomObject = object;
            if (_loc2_ == null) {
                return false;
            }
            var _loc6_: IRoomObjectModel;
            if ((_loc6_ = _loc2_.getModel()) == null) {
                return false;
            }
            var _loc8_: String = String(_loc6_.getString("furniture_planetsystem_data"));
            var _loc7_: XMLList;
            var _loc3_: XMLList = (_loc7_ = XMLList(_loc8_)).children();
            var _loc1_: int = _loc3_.length();
            var_2016 = [];
            var_3815 = [];
            _loc5_ = 0;
            while (_loc5_ < _loc1_) {
                _loc9_ = _loc3_[_loc5_];
                if ((_loc4_ = getSprite(_loc5_)) != null) {
                    addPlanet(_loc9_.@name, _loc5_, _loc9_.@parent, Number(_loc9_.@radius), Number(_loc9_.@arcspeed), Number(_loc9_.@arcoffset), Number(_loc9_.@height));
                }
                _loc5_++;
            }
            return true;
        }

        private function addPlanet(param1: String, param2: int, param3: String, param4: Number, param5: Number, param6: Number, param7: Number): void {
            var _loc8_: FurniturePlanetSystemVisualizationPlanetObject = null;
            if (var_2016 == null) {
                return;
            }
            var _loc9_: FurniturePlanetSystemVisualizationPlanetObject = new FurniturePlanetSystemVisualizationPlanetObject(param1, param2, param4, param5, param6, param7);
            if ((_loc8_ = getPlanet(param3)) != null) {
                _loc8_.addChild(_loc9_);
            } else {
                var_2016.push(_loc9_);
                var_3815.push(param1);
            }
        }

        private function getPlanet(param1: String): FurniturePlanetSystemVisualizationPlanetObject {
            var _loc2_: FurniturePlanetSystemVisualizationPlanetObject = null;
            var _loc3_: int = 0;
            _loc3_ = 0;
            while (_loc3_ < var_2016.length) {
                _loc2_ = var_2016[_loc3_];
                if (_loc2_.name == param1) {
                    return _loc2_;
                }
                if (_loc2_.hasChild(param1)) {
                    return _loc2_.getChild(param1);
                }
                _loc3_++;
            }
            return null;
        }
    }
}
