package com.sulake.habbo.room.object.visualization.furniture {
    import flash.geom.Vector3D
    import flash.utils.Dictionary

    public class FurnitureParticleSystemEmitter extends FurnitureParticleSystemParticle {

        public static const SHAPE_CONE: String = "cone";

        public static const SHAPE_PLANE: String = "plane";

        public static const SHAPE_SPHERE: String = "sphere";

        public function FurnitureParticleSystemEmitter(param1: String = "", param2: int = -1) {
            var_2034 = [];
            super();
            _name = param1;
            var_4854 = param2;
            var_3154 = [];
        }
        private var _name: String;
        private var var_4854: int = -1;
        private var var_3564: Number;
        private var var_1210: Vector3D;
        private var var_2653: Number = 0.1;
        private var var_3242: Number;
        private var var_1887: Number;
        private var var_3580: String;
        private var var_3154: Array;
        private var var_2034: Array;
        private var var_3735: int;
        private var _particlesPerFrame: int;
        private var var_2867: int;
        private var _fuseTime: int = 10;
        private var var_883: Number = 1;
        private var var_2630: Boolean = false;
        private var var_3596: int = 1;

        public function get particles(): Array {
            return var_2034;
        }

        public function get hasIgnited(): Boolean {
            return var_2630;
        }

        public function get roomObjectSpriteId(): int {
            return var_4854;
        }

        override public function dispose(): void {
            for each(var _loc1_ in var_2034) {
                _loc1_.dispose();
            }
            var_2034 = null;
            var_1210 = null;
            var_3154 = null;
            super.dispose();
        }

        override protected function ignite(): void {
            var_2630 = true;
            if (var_2867 < var_3735) {
                if (this.age > 1) {
                    releaseParticles(this, this.direction);
                }
            }
        }

        override public function update(): void {
            super.update();
            accumulateForces();
            verlet();
            satisfyConstraints();
            if (!isAlive && var_2867 < var_3735) {
                if (this.age % var_3596 == 0) {
                    releaseParticles(this, this.direction);
                }
            }
        }

        public function setup(param1: int, param2: int, param3: Number, param4: Vector3D, param5: Number, param6: Number, param7: String, param8: Number, param9: int, param10: int): void {
            var_3735 = param1;
            _particlesPerFrame = param2;
            var_3564 = param3;
            var_1210 = param4;
            var_1210.normalize();
            var_3242 = param5;
            var_1887 = param6;
            var_3580 = param7;
            _fuseTime = param9;
            var_883 = param8;
            var_3596 = param10;
            reset();
        }

        public function reset(): void {
            for each(var _loc1_ in var_2034) {
                _loc1_.dispose();
            }
            var_2034 = [];
            var_2867 = 0;
            var_2630 = false;
            this.init(0, 0, 0, var_1210, var_3564, var_2653, _fuseTime, true);
        }

        public function copyStateFrom(param1: FurnitureParticleSystemEmitter, param2: Number): void {
            super.copy(param1, param2);
            var_3564 = param1.var_3564;
            var_1210 = param1.var_1210;
            var_3242 = param1.var_3242;
            var_1887 = param1.var_1887;
            var_3580 = param1.var_3580;
            _fuseTime = param1._fuseTime;
            var_883 = param1.var_883;
            var_3596 = param1.var_3596;
            var_2653 = param1.var_2653;
            var_2630 = param1.var_2630;
        }

        public function configureParticle(param1: int, param2: Boolean, param3: Array, param4: Boolean): void {
            var _loc5_: Dictionary;
            (_loc5_ = new Dictionary())["lifeTime"] = param1;
            _loc5_["isEmitter"] = param2;
            _loc5_["frames"] = param3;
            _loc5_["fade"] = param4;
            var_3154.push(_loc5_);
        }

        public function verlet(): void {
            var _loc2_: Number = NaN;
            var _loc3_: Number = NaN;
            var _loc4_: Number = NaN;
            var _loc5_: * = null;
            if (isAlive || var_2867 < var_3735) {
                _loc2_ = this.x;
                _loc3_ = this.y;
                _loc4_ = this.z;
                this.x = (2 - var_1887) * this.x - (1 - var_1887) * this.lastX;
                this.y = (2 - var_1887) * this.y - (1 - var_1887) * this.lastY + var_3242 * var_2653 * var_2653;
                this.z = (2 - var_1887) * this.z - (1 - var_1887) * this.lastZ;
                this.lastX = _loc2_;
                this.lastY = _loc3_;
                this.lastZ = _loc4_;
            }
            var _loc1_: Array = [];
            for each(_loc5_ in var_2034) {
                _loc5_.update();
                _loc2_ = _loc5_.x;
                _loc3_ = _loc5_.y;
                _loc4_ = _loc5_.z;
                _loc5_.x = (2 - var_1887) * _loc5_.x - (1 - var_1887) * _loc5_.lastX;
                _loc5_.y = (2 - var_1887) * _loc5_.y - (1 - var_1887) * _loc5_.lastY + var_3242 * var_2653 * var_2653;
                _loc5_.z = (2 - var_1887) * _loc5_.z - (1 - var_1887) * _loc5_.lastZ;
                _loc5_.lastX = _loc2_;
                _loc5_.lastY = _loc3_;
                _loc5_.lastZ = _loc4_;
                if (_loc5_.y > 10 || !_loc5_.isAlive) {
                    _loc1_.push(_loc5_);
                }
            }
            for each(_loc5_ in _loc1_) {
                if (!_loc5_.isEmitter) {
                }
                var_2034.splice(var_2034.indexOf(_loc5_), 1);
                _loc5_.dispose();
            }
        }

        private function releaseParticles(param1: FurnitureParticleSystemParticle, param2: Vector3D = null): void {
            var _loc8_: FurnitureParticleSystemParticle = null;
            var _loc3_: Dictionary = null;
            var _loc10_: int = 0;
            var _loc6_: Array = null;
            var _loc7_: int = 0;
            if (!param2) {
                param2 = new Vector3D();
            }
            var _loc9_: Vector3D = new Vector3D();
            var _loc4_: Boolean = false;
            var _loc5_: Boolean = false;
            _loc3_ = getRandomParticleConfiguration();
            _loc7_ = 0;
            while (_loc7_ < _particlesPerFrame) {
                switch (var_3580) {
                    case "cone":
                        _loc9_.x = randomBoolean(0.5) ? Math.random() : -Math.random();
                        _loc9_.y = -(Math.random() + 1);
                        _loc9_.z = randomBoolean(0.5) ? Math.random() : -Math.random();
                        break;
                    case "plane":
                        _loc9_.x = randomBoolean(0.5) ? Math.random() : -Math.random();
                        _loc9_.y = 0;
                        _loc9_.z = randomBoolean(0.5) ? Math.random() : -Math.random();
                        break;
                    case "sphere":
                        _loc9_.x = randomBoolean(0.5) ? Math.random() : -Math.random();
                        _loc9_.y = randomBoolean(0.5) ? Math.random() : -Math.random();
                        _loc9_.z = randomBoolean(0.5) ? Math.random() : -Math.random();
                }
                _loc9_.normalize();
                _loc8_ = new FurnitureParticleSystemParticle();
                if (_loc3_) {
                    _loc10_ = Math.floor(Math.random() * _loc3_["lifeTime"] + 10);
                    _loc4_ = Boolean(_loc3_["isEmitter"]);
                    _loc6_ = _loc3_["frames"];
                    _loc5_ = Boolean(_loc3_["fade"]);
                } else {
                    _loc10_ = Math.floor(Math.random() * 20 + 10);
                    _loc4_ = false;
                    _loc6_ = [];
                }
                _loc8_.init(param1.x, param1.y, param1.z, _loc9_, var_883, var_2653, _loc10_, _loc4_, _loc6_, _loc5_);
                var_2034.push(_loc8_);
                var_2867++;
                _loc7_++;
            }
        }

        private function getRandomParticleConfiguration(): Dictionary {
            var _loc1_: int = Math.floor(Math.random() * var_3154.length);
            return var_3154[_loc1_];
        }

        private function satisfyConstraints(): void {
        }

        private function accumulateForces(): void {
            for each(var _loc1_ in var_2034) {
            }
        }

        private function randomBoolean(param1: Number): Boolean {
            return Math.random() < param1;
        }
    }
}
