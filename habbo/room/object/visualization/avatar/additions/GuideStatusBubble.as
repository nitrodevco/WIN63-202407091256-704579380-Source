package com.sulake.habbo.room.object.visualization.avatar.additions {
    import com.sulake.core.assets.BitmapDataAsset
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization
    import com.sulake.room.object.visualization.IRoomObjectSprite

    import flash.display.BitmapData

    public class GuideStatusBubble implements class_3545 {

        public function GuideStatusBubble(param1: int, param2: AvatarVisualization, param3: int) {
            super();
            var_280 = param1;
            var_254 = param2;
            _status = param3;
        }
        private var var_280: int = -1;
        private var _asset: BitmapDataAsset;
        private var var_254: AvatarVisualization;
        private var _status: int;

        private var _relativeDepth: Number = 0;

        public function set relativeDepth(param1: Number): void {
            _relativeDepth = param1;
        }

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

        public function animate(param1: IRoomObjectSprite): Boolean {
            if (_asset && param1) {
                param1.asset = _asset.content as BitmapData;
            }
            return false;
        }

        public function update(param1: IRoomObjectSprite, param2: Number): void {
            var _loc3_: int = 0;
            var _loc4_: int = 0;
            if (!param1) {
                return;
            }
            param1.visible = true;
            param1.relativeDepth = _relativeDepth;
            param1.alpha = 255;
            var _loc5_: int = 64;
            var _loc6_: String = _status == 1 ? "user_guide_bubble_png" : "user_guide_requester_bubble_png";
            if (param2 < 48) {
                _asset = var_254.getAvatarRendererAsset(_loc6_) as BitmapDataAsset;
                _loc3_ = -19;
                _loc4_ = -80;
                _loc5_ = 32;
            } else {
                _asset = var_254.getAvatarRendererAsset(_loc6_) as BitmapDataAsset;
                _loc3_ = -19;
                _loc4_ = -120;
            }
            if (var_254.posture == "sit") {
                _loc4_ += _loc5_ / 2;
            } else if (var_254.posture == "lay") {
                _loc4_ += _loc5_;
            }
            if (_asset != null) {
                param1.asset = _asset.content as BitmapData;
                param1.offsetX = _loc3_;
                param1.offsetY = _loc4_;
                param1.relativeDepth = -0.02;
            }
        }
    }
}
