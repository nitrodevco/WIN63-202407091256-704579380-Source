package com.sulake.habbo.room.object.visualization.furniture {
    import com.sulake.core.utils.Map
    import com.sulake.room.object.visualization.IRoomObjectSprite
    import com.sulake.room.object.visualization.utils.IGraphicAsset

    import flash.display.BitmapData
    import flash.geom.ColorTransform
    import flash.geom.Matrix
    import flash.geom.Point
    import flash.geom.Rectangle
    import flash.geom.Vector3D

    public class FurnitureParticleSystem {

        public function FurnitureParticleSystem(param1: AnimatedFurnitureVisualization) {
            super();
            _emitters = new Map();
            _visualization = param1;
            var_2598 = new ColorTransform();
            var_2598.alphaMultiplier = 1;
            var_3354 = new ColorTransform();
            var_3845 = new Matrix();
            var_3030 = new Matrix();
        }
        private var _emitters: Map;
        private var _visualization: AnimatedFurnitureVisualization;
        private var var_3648: int;
        private var var_4149: int;
        private var _offsetY: int;
        private var var_1720: FurnitureParticleSystemEmitter;
        private var var_1696: BitmapData;
        private var var_1919: IRoomObjectSprite;
        private var var_2630: Boolean = false;
        private var var_4639: int = 0;
        private var var_4540: int = 0;
        private var var_3299: Number = 1;
        private var var_2537: BitmapData;
        private var var_2598: ColorTransform;
        private var var_3354: ColorTransform;
        private var var_3845: Matrix;
        private var var_3030: Matrix;
        private var var_2314: Number = 1;
        private var _bgColor: uint = 4278190080;

        public function dispose(): void {
            for each(var _loc1_ in _emitters) {
                _loc1_.dispose();
            }
            _emitters = null;
            if (var_1696) {
                var_1696.dispose();
                var_1696 = null;
            }
            if (var_2537) {
                var_2537.dispose();
                var_2537 = null;
            }
            var_2598 = null;
            var_3354 = null;
            var_3845 = null;
            var_3030 = null;
        }

        public function reset(): void {
            if (var_1720) {
                var_1720.reset();
            }
            var_1720 = null;
            var_2630 = false;
            updateCanvas();
        }

        public function setAnimation(param1: int): void {
            if (var_1720) {
                var_1720.reset();
            }
            var_1720 = _emitters[param1];
            var_2630 = false;
            updateCanvas();
        }

        public function getSpriteYOffset(param1: int, param2: int, param3: int): int {
            if (var_1720 && var_1720.roomObjectSpriteId == param3) {
                return var_1720.y * var_3299;
            }
            return 0;
        }

        public function controlsSprite(param1: int): Boolean {
            if (var_1720) {
                return var_1720.roomObjectSpriteId == param1;
            }
            return false;
        }

        public function updateSprites(): void {
            if (!var_1720 || !var_1919) {
                return;
            }
            if (var_1696 && var_1919.asset != var_1696) {
                var_1919.asset = var_1696;
                var_1919.asset.width;
            }
            if (var_2630) {
                if (var_1720.roomObjectSpriteId >= 0) {
                    _visualization.getSprite(var_1720.roomObjectSpriteId).visible = false;
                }
            }
        }

        public function updateAnimation(): void {
            var _loc9_: int = 0;
            var _loc10_: int = 0;
            var _loc1_: Rectangle = null;
            var _loc11_: IGraphicAsset = null;
            var _loc3_: BitmapData = null;
            var _loc6_: * = null;
            var _loc8_: Point = null;
            if (!var_1720 || !var_1919) {
                return;
            }
            var _loc5_: Number = 10;
            var _loc4_: Number = 0;
            var _loc2_: int = 0;
            if (!var_2630 && var_1720.hasIgnited) {
                var_2630 = true;
            }
            _loc2_ = _offsetY * var_3299;
            var_1720.update();
            if (var_2630) {
                if (var_1720.roomObjectSpriteId >= 0) {
                    _visualization.getSprite(var_1720.roomObjectSpriteId).visible = false;
                }
                if (!var_1696) {
                    updateCanvas();
                }
                var_1696.lock();
                if (var_2598.alphaMultiplier == 1) {
                    var_1696.fillRect(var_1696.rect, _bgColor);
                } else {
                    var_1696.draw(var_2537, var_3845, var_2598, "normal", null, false);
                }
                for each(var _loc7_ in var_1720.particles) {
                    _loc4_ = Number(_loc7_.y);
                    _loc9_ = var_4639 + (_loc7_.x - _loc7_.z) * _loc5_ / 10 * var_3299;
                    _loc10_ = var_4540 - _loc2_ + (_loc4_ + (_loc7_.x + _loc7_.z) / 2) * _loc5_ / 10 * var_3299;
                    if (_loc11_ = _loc7_.getAsset()) {
                        _loc3_ = _loc11_.asset.content as BitmapData;
                        if (_loc7_.fade && _loc7_.alphaMultiplier < 1) {
                            var_3030.identity();
                            var_3030.translate(_loc9_ + _loc11_.offsetX, _loc10_ + _loc11_.offsetY);
                            var_3354.alphaMultiplier = _loc7_.alphaMultiplier;
                            var_1696.draw(_loc3_, var_3030, var_3354, "normal", null, false);
                        } else {
                            _loc8_ = new Point(_loc9_ + _loc11_.offsetX, _loc10_ + _loc11_.offsetY);
                            var_1696.copyPixels(_loc3_, _loc3_.rect, _loc8_, null, null, true);
                        }
                    } else {
                        _loc1_ = new Rectangle(_loc9_ - 1, _loc10_ - 1, 2, 2);
                        var_1696.fillRect(_loc1_, 4294967295);
                    }
                }
                var_1696.unlock();
            }
        }

        public function parseData(param1: XML): void {
            var _loc7_: * = null;
            var _loc9_: int = 0;
            var _loc21_: String = null;
            var _loc4_: int = 0;
            var _loc24_: FurnitureParticleSystemEmitter = null;
            var _loc19_: int = 0;
            var _loc14_: int = 0;
            var _loc25_: int = 0;
            var _loc18_: int = 0;
            var _loc22_: Number = NaN;
            var _loc11_: Number = NaN;
            var _loc20_: Number = NaN;
            var _loc3_: Number = NaN;
            var _loc15_: String = null;
            var _loc12_: Number = NaN;
            var _loc10_: int = 0;
            var _loc13_: Boolean = false;
            var _loc5_: Boolean = false;
            var _loc16_: Array = null;
            var _loc23_: IGraphicAsset = null;
            var_3648 = parseInt(param1.@size);
            var_4149 = param1.hasOwnProperty("@canvas_id") ? parseInt(param1.@canvas_id) : -1;
            _offsetY = param1.hasOwnProperty("@offset_y") ? parseInt(param1.@offset_y) : 10;
            var_3299 = var_3648 / 64;
            var_2314 = param1.hasOwnProperty("@blend") ? Number(param1.@blend) : 1;
            var_2314 = Math.min(var_2314, 1);
            var_2598.alphaMultiplier = var_2314;
            var _loc8_: String = param1.hasOwnProperty("@bgcolor") ? String(param1.@bgcolor) : "0";
            _bgColor = param1.hasOwnProperty("@bgcolor") ? parseInt(_loc8_, 16) : 4278190080;
            for each(var _loc6_ in param1.emitter) {
                _loc9_ = parseInt(_loc6_.@id);
                _loc21_ = _loc6_.@name;
                _loc4_ = parseInt(_loc6_.@sprite_id);
                _loc24_ = new FurnitureParticleSystemEmitter(_loc21_, _loc4_);
                _emitters[_loc9_] = _loc24_;
                _loc19_ = parseInt(_loc6_.@max_num_particles);
                _loc14_ = parseInt(_loc6_.@particles_per_frame);
                _loc25_ = _loc6_.hasOwnProperty("@burst_pulse") ? parseInt(_loc6_.@burst_pulse) : 1;
                _loc18_ = parseInt(_loc6_.@fuse_time);
                _loc22_ = Number(_loc6_.simulation.@force);
                _loc11_ = Number(_loc6_.simulation.@direction);
                _loc20_ = Number(_loc6_.simulation.@gravity);
                _loc3_ = Number(_loc6_.simulation.@airfriction);
                _loc15_ = _loc6_.simulation.@shape;
                _loc12_ = Number(_loc6_.simulation.@energy);
                for each(var _loc17_ in _loc6_.particles.particle) {
                    _loc10_ = parseInt(_loc17_.@lifetime);
                    _loc13_ = _loc17_.@is_emitter == "false" ? false : true;
                    _loc5_ = _loc17_.hasOwnProperty("@fade") && _loc17_.@fade == "true" ? true : false;
                    _loc16_ = [];
                    for each(var _loc2_ in _loc17_.frame) {
                        _loc23_ = _visualization.assetCollection.getAsset(_loc2_.@name);
                        _loc16_.push(_loc23_);
                    }
                    _loc24_.configureParticle(_loc10_, _loc13_, _loc16_, _loc5_);
                }
                _loc24_.setup(_loc19_, _loc14_, _loc22_, new Vector3D(0, _loc11_, 0), _loc20_, _loc3_, _loc15_, _loc12_, _loc18_, _loc25_);
            }
        }

        public function copyStateFrom(param1: FurnitureParticleSystem): void {
            var _loc2_: int = 0;
            if (param1._emitters && param1.var_1720) {
                _loc2_ = param1._emitters.getKey(param1._emitters.getValues().indexOf(param1.var_1720));
            }
            setAnimation(_loc2_);
            if (var_1720) {
                var_1720.copyStateFrom(param1.var_1720, param1.var_3648 / var_3648);
            }
            var_1696 = null;
        }

        private function updateCanvas(): void {
            if (!var_1720) {
                return;
            }
            if (var_4149 >= 0) {
                var_1919 = _visualization.getSprite(var_4149);
                if (var_1919 && var_1919.asset) {
                    if (var_1919.width <= 1 || var_1919.height <= 1) {
                        return;
                    }
                    if (var_1696 && (var_1696.width != var_1919.width || var_1696.height != var_1919.height)) {
                        var_1696 = null;
                    }
                    if (var_1696 == null) {
                        var_1696 = var_1919.asset.clone();
                        if (var_2598.alphaMultiplier != 1) {
                            var_2537 = new BitmapData(var_1696.width, var_1696.height, true, _bgColor);
                        }
                    }
                    var_4639 = -var_1919.offsetX;
                    var_4540 = -var_1919.offsetY;
                    var_1919.asset = var_1696;
                }
                if (var_1696) {
                    var_1696.fillRect(var_1696.rect, _bgColor);
                }
                if (var_2537) {
                    var_2537.fillRect(var_2537.rect, _bgColor);
                }
            }
        }
    }
}
