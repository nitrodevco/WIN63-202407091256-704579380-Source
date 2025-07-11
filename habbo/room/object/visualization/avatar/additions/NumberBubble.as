package com.sulake.habbo.room.object.visualization.avatar.additions {
    import com.sulake.core.assets.BitmapDataAsset
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization
    import com.sulake.room.object.visualization.IRoomObjectSprite

    import flash.display.BitmapData

    public class NumberBubble implements class_3545 {

        public function NumberBubble(param1: int, param2: int, param3: AvatarVisualization) {
            super();
            var_280 = param1;
            var_3726 = param2;
            var_254 = param3;
        }
        private var var_280: int = -1;
        private var var_254: AvatarVisualization;
        private var _asset: BitmapDataAsset;
        private var var_911: Number;
        private var var_3726: int = 0;
        private var var_2384: int = 0;
        private var var_3961: Boolean = false;
        private var var_3278: int = 0;

        public function get id(): int {
            return var_280;
        }

        public function get disposed(): Boolean {
            return var_254 == null;
        }

        public function dispose(): void {
            var_254 = null;
            _asset = null;
        }

        public function update(param1: IRoomObjectSprite, param2: Number): void {
            var _loc3_: int = 0;
            var _loc4_: int = 0;
            var _loc5_: int = 0;
            if (!param1) {
                return;
            }
            var_911 = param2;
            if (var_3726 > 0) {
                _loc5_ = 64;
                if (param2 < 48) {
                    _asset = var_254.getAvatarRendererAsset("number_" + var_3726 + "_small_png") as BitmapDataAsset;
                    _loc3_ = -6;
                    _loc4_ = -52;
                    _loc5_ = 32;
                } else {
                    _asset = var_254.getAvatarRendererAsset("number_" + var_3726 + "_png") as BitmapDataAsset;
                    _loc3_ = -8;
                    _loc4_ = -105;
                }
                if (var_254.posture == "sit") {
                    _loc4_ += _loc5_ / 2;
                } else if (var_254.posture == "lay") {
                    _loc4_ += _loc5_;
                }
                if (_asset != null) {
                    param1.visible = true;
                    param1.asset = _asset.content as BitmapData;
                    param1.offsetX = _loc3_;
                    param1.offsetY = _loc4_;
                    param1.relativeDepth = -0.01;
                    var_2384 = 1;
                    var_3961 = true;
                    var_3278 = 0;
                    param1.alpha = 0;
                } else {
                    param1.visible = false;
                }
            } else if (param1.visible) {
                var_2384 = -1;
            }
        }

        public function animate(param1: IRoomObjectSprite): Boolean {
            var _loc2_: int = 0;
            if (!param1) {
                return false;
            }
            if (_asset) {
                param1.asset = _asset.content as BitmapData;
            }
            var _loc3_: int = param1.alpha;
            var _loc4_: Boolean = false;
            if (var_3961) {
                var_3278++;
                if (var_3278 < 10) {
                    return false;
                }
                if (var_2384 < 0) {
                    if (var_911 < 48) {
                        param1.offsetY -= 2;
                    } else {
                        param1.offsetY -= 4;
                    }
                } else {
                    _loc2_ = 4;
                    if (var_911 < 48) {
                        _loc2_ = 8;
                    }
                    if (var_3278 % _loc2_ == 0) {
                        param1.offsetY -= 1;
                        _loc4_ = true;
                    }
                }
            }
            if (var_2384 > 0) {
                if (_loc3_ < 255) {
                    _loc3_ += 32;
                }
                if (_loc3_ >= 255) {
                    _loc3_ = 255;
                    var_2384 = 0;
                }
                param1.alpha = _loc3_;
                return true;
            }
            if (var_2384 < 0) {
                if (_loc3_ >= 0) {
                    _loc3_ -= 32;
                }
                if (_loc3_ <= 0) {
                    var_2384 = 0;
                    var_3961 = false;
                    _loc3_ = 0;
                    param1.visible = false;
                }
                param1.alpha = _loc3_;
                return true;
            }
            return _loc4_;
        }
    }
}
