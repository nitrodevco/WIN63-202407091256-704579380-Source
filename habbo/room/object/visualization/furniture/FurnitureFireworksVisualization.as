package com.sulake.habbo.room.object.visualization.furniture {
    import assets.class_14

    import com.sulake.room.object.IRoomObject
    import com.sulake.room.object.IRoomObjectModel

    import flash.utils.Dictionary

    public class FurnitureFireworksVisualization extends AnimatedFurnitureVisualization {

        public function FurnitureFireworksVisualization() {
            super();
        }
        private var _particleSystems: Dictionary;
        private var var_1831: FurnitureParticleSystem;

        override public function dispose(): void {
            super.dispose();
            var_1831 = null;
            if (_particleSystems) {
                for each(var _loc1_ in _particleSystems) {
                    _loc1_.dispose();
                }
                _particleSystems = null;
            }
        }

        override protected function updateObject(param1: Number, param2: Number): Boolean {
            var _loc3_: Boolean = false;
            var _loc4_: FurnitureParticleSystem = null;
            if (super.updateObject(param1, param2)) {
                _loc3_ = false;
                if (!_particleSystems) {
                    readDefinition();
                    if (_particleSystems) {
                        var_1831 = _particleSystems[param1];
                        _loc3_ = true;
                    } else {
                        class_14.log("ERROR Particle systems could not be read! " + this.object.getType());
                    }
                } else if (param1 != var_1755 || _particleSystems[param1] != var_1831) {
                    (_loc4_ = _particleSystems[param1]).copyStateFrom(var_1831);
                    if (var_1831) {
                        var_1831.reset();
                    }
                    var_1831 = _loc4_;
                    _loc3_ = true;
                }
                return true;
            }
            return false;
        }

        override protected function updateSprites(param1: int, param2: Boolean, param3: int): void {
            super.updateSprites(param1, param2, param3);
            if (var_1831) {
                var_1831.updateSprites();
            }
        }

        override protected function updateAnimation(param1: Number): int {
            if (var_1831) {
                var_1831.updateAnimation();
            }
            return super.updateAnimation(param1);
        }

        override protected function setAnimation(param1: int): void {
            if (var_1831) {
                var_1831.setAnimation(param1);
            }
            super.setAnimation(param1);
        }

        override protected function getSpriteYOffset(param1: int, param2: int, param3: int): int {
            if (var_1831 && var_1831.controlsSprite(param3)) {
                return var_1831.getSpriteYOffset(param1, param2, param3);
            }
            return super.getSpriteYOffset(param1, param2, param3);
        }

        private function readDefinition(): Boolean {
            var _loc1_: FurnitureParticleSystem = null;
            var _loc4_: int = 0;
            var _loc5_: IRoomObject;
            if ((_loc5_ = object) == null) {
                return false;
            }
            var _loc7_: IRoomObjectModel;
            if ((_loc7_ = _loc5_.getModel()) == null) {
                return false;
            }
            var _loc6_: String;
            if (!(_loc6_ = String(_loc7_.getString("furniture_fireworks_data"))) || _loc6_.length == 0) {
                class_14.log("No Particle System Data Found.");
                return false;
            }
            var _loc3_: XML = XML(_loc6_);
            _particleSystems = new Dictionary();
            for each(var _loc2_ in _loc3_.particlesystem) {
                if (!_loc2_.hasOwnProperty("@size")) {
                    class_14.log("Particle System does not have size property!");
                } else {
                    _loc4_ = int(_loc2_.@size);
                    _loc1_ = new FurnitureParticleSystem(this);
                    _loc1_.parseData(_loc2_);
                    _particleSystems[_loc4_] = _loc1_;
                }
            }
            return true;
        }
    }
}
