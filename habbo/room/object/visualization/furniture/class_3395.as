package com.sulake.habbo.room.object.visualization.furniture {
    import com.sulake.room.object.visualization.IRoomObjectSprite
    import com.sulake.room.object.visualization.utils.IGraphicAsset

    public class class_3395 extends AnimatedFurnitureVisualization {

        private static const BADGE_SPRITE_TAG: String = "BADGE";

        public function class_3395() {
            super();
        }
        private var var_3156: String = "";
        private var var_3339: String = "";
        private var var_4046: int = -1;

        override protected function updateModel(param1: Number): Boolean {
            var _loc2_: * = false;
            var _loc3_: Boolean = super.updateModel(param1);
            if (!isNaN(object.getModel().getNumber("furniture_badge_image_status"))) {
                _loc2_ = object.getModel().getNumber("furniture_badge_image_status") != 0;
                if (_loc2_ && var_3156 == "") {
                    var_3156 = object.getModel().getString("furniture_badge_asset_name");
                    if (var_3339 == "") {
                        var_3339 = var_3156 + "_32";
                    }
                    if (object.getModel().hasNumber("furniture_badge_visible_in_state")) {
                        var_4046 = object.getModel().getNumber("furniture_badge_visible_in_state");
                    }
                    _loc3_ = true;
                }
            }
            return _loc3_;
        }

        override protected function getSpriteAssetName(param1: int, param2: int): String {
            var _loc3_: String = getSpriteTag(param1, direction, param2);
            if (_loc3_ != "BADGE" || var_4046 != -1 && object.getState(0) != var_4046) {
                return super.getSpriteAssetName(param1, param2);
            }
            if (param1 == 32) {
                return var_3339;
            }
            return var_3156;
        }

        override protected function getSpriteXOffset(param1: int, param2: int, param3: int): int {
            var _loc5_: IGraphicAsset = null;
            var _loc4_: int = super.getSpriteXOffset(param1, param2, param3);
            if (getSpriteTag(param1, param2, param3) == "BADGE") {
                _loc5_ = getAsset(param1 == 32 ? var_3339 : var_3156, param3);
                if (param1 == 64) {
                    _loc4_ += (40 - _loc5_.width) / 2;
                    if (param2 == 2 && (type == "china_c24_resolution1" || type == "china_c24_resolution2")) {
                        _loc4_ -= 40;
                    }
                } else {
                    _loc4_ += (20 - _loc5_.width) / 2;
                }
            }
            return _loc4_;
        }

        override protected function getSpriteYOffset(param1: int, param2: int, param3: int): int {
            var _loc5_: IGraphicAsset = null;
            var _loc4_: int = super.getSpriteYOffset(param1, param2, param3);
            if (getSpriteTag(param1, param2, param3) == "BADGE") {
                _loc5_ = getAsset(param1 == 32 ? var_3339 : var_3156, param3);
                if (param1 == 64) {
                    _loc4_ += (40 - _loc5_.height) / 2;
                } else {
                    _loc4_ += (20 - _loc5_.height) / 2;
                }
            }
            return _loc4_;
        }

        override protected function getLibraryAssetNameForSprite(param1: IGraphicAsset, param2: IRoomObjectSprite): String {
            if (param2.tag == "BADGE") {
                return "%image.library.url%album1584/" + param2.assetName.replace("badge_", "") + ".png";
            }
            return super.getLibraryAssetNameForSprite(param1, param2);
        }
    }
}
