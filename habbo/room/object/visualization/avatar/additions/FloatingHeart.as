package com.sulake.habbo.room.object.visualization.avatar.additions {
    import com.sulake.core.assets.BitmapDataAsset
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization
    import com.sulake.room.object.visualization.IRoomObjectSprite

    import flash.display.BitmapData
    import flash.utils.getTimer

    public class FloatingHeart extends ExpressionAddition {

        private static const DELAY_BEFORE_ANIMATION: int = 300;

        private static const STATE_DELAY: int = 0;

        private static const STATE_FADE_IN: int = 1;

        private static const STATE_FLOAT: int = 2;

        private static const STATE_COMPLETE: int = 3;

        public function FloatingHeart(param1: int, param2: int, param3: AvatarVisualization) {
            super(param1, param2, param3);
            _startTime = getTimer();
            var_149 = 0;
        }
        private var _asset: BitmapDataAsset;
        private var _startTime: int;
        private var var_1893: Number = 0;
        private var _offsetY: int;
        private var var_911: Number;
        private var var_149: int = -1;

        override public function animate(param1: IRoomObjectSprite): Boolean {
            var _loc3_: Number = NaN;
            var _loc2_: int = 0;
            if (!param1) {
                return false;
            }
            if (_asset) {
                param1.asset = _asset.content as BitmapData;
            }
            if (var_149 == 0) {
                if (getTimer() - _startTime < 300) {
                    return false;
                }
                var_149 = 1;
                param1.alpha = 0;
                param1.visible = true;
                var_1893 = 0;
                return true;
            }
            if (var_149 == 1) {
                var_1893 += 0.1;
                param1.offsetY = _offsetY;
                param1.alpha = Math.pow(var_1893, 0.9) * 255;
                if (var_1893 >= 1) {
                    var_1893 = 0;
                    param1.alpha = 255;
                    var_149 = 2;
                }
                return true;
            }
            if (var_149 == 2) {
                _loc3_ = Math.pow(var_1893, 0.9);
                var_1893 += 0.05;
                _loc2_ = var_911 < 48 ? -30 : -40;
                param1.offsetY = _offsetY + (var_1893 < 1 ? _loc3_ : 1) * _loc2_;
                param1.alpha = (1 - _loc3_) * 255;
                if (param1.alpha <= 0) {
                    param1.visible = false;
                    var_149 = 3;
                }
                return true;
            }
            return false;
        }

        override public function update(param1: IRoomObjectSprite, param2: Number): void {
            var _loc3_: int = 0;
            var _loc5_: Number = NaN;
            if (!param1) {
                return;
            }
            var_911 = param2;
            var _loc4_: int = 64;
            if (param2 < 48) {
                _asset = var_254.getAvatarRendererAsset("user_blowkiss_small_png") as BitmapDataAsset;
                if (var_254.angle == 90 || var_254.angle == 270) {
                    _loc3_ = 0;
                } else if (var_254.angle == 135 || var_254.angle == 180 || var_254.angle == 225) {
                    _loc3_ = 6;
                } else {
                    _loc3_ = -6;
                }
                _offsetY = -38;
                _loc4_ = 32;
            } else {
                _asset = var_254.getAvatarRendererAsset("user_blowkiss_png") as BitmapDataAsset;
                if (var_254.angle == 90 || var_254.angle == 270) {
                    _loc3_ = -3;
                } else if (var_254.angle == 135 || var_254.angle == 180 || var_254.angle == 225) {
                    _loc3_ = 22;
                } else {
                    _loc3_ = -30;
                }
                _offsetY = -70;
            }
            if (var_254.posture == "sit") {
                _offsetY += _loc4_ / 2;
            } else if (var_254.posture == "lay") {
                _offsetY += _loc4_;
            }
            if (_asset != null) {
                param1.asset = _asset.content as BitmapData;
                param1.offsetX = _loc3_;
                param1.offsetY = _offsetY;
                param1.relativeDepth = -0.02;
                param1.alpha = 0;
                _loc5_ = var_1893;
                animate(param1);
                var_1893 = _loc5_;
            }
        }
    }
}
