package com.sulake.habbo.room.object.visualization.pet {
    import com.sulake.core.assets.BitmapDataAsset
    import com.sulake.habbo.room.object.visualization.data.AnimationData
    import com.sulake.habbo.room.object.visualization.data.AnimationFrame
    import com.sulake.habbo.room.object.visualization.data.AnimationStateData
    import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualizationData
    import com.sulake.room.object.IRoomObject
    import com.sulake.room.object.IRoomObjectModel
    import com.sulake.room.object.visualization.IRoomObjectSprite
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData
    import com.sulake.room.object.visualization.utils.IGraphicAsset
    import com.sulake.room.utils.IRoomGeometry

    import flash.display.BitmapData

    public class AnimatedPetVisualization extends AnimatedFurnitureVisualization {

        private static const HEAD_SPRITE_TAG: String = "head";

        private static const SADDLE_SPRITE_TAG: String = "saddle";

        private static const HAIR_SPRITE_TAG: String = "hair";

        private static const ADDITIONAL_SPRITE_COUNT: int = 1;

        private static const EXPERIENCE_BUBBLE_VISIBLE_IN_MS: int = 1000;

        private static const EXPERIENCE_BUBBLE_ASSET_NAME: String = "pet_experience_bubble_png";

        private static const POSTURE_ANIMATION_INDEX: int = 0;

        private static const GESTURE_ANIMATION_INDEX: int = 1;

        private static const const_1154: int = 2;

        public function AnimatedPetVisualization() {
            var_3097 = [];
            var_3802 = [];
            var_3835 = [];
            var_1796 = [];
            _headSprites = [];
            var_3211 = [];
            var_3557 = [];
            super();
            while (var_1796.length < 2) {
                var_1796.push(new AnimationStateData());
            }
        }
        private var var_917: String = "";
        private var var_471: String = "";
        private var var_3901: Boolean = false;
        private var _headDirection: int = 0;
        private var var_2101: ExperienceData;
        private var var_3598: int = 0;
        private var var_1365: int = 0;
        private var var_1793: AnimatedPetVisualizationData = null;
        private var _paletteName: String = "";
        private var var_4124: int = -1;
        private var var_3097: Array;
        private var var_3802: Array;
        private var var_3835: Array;
        private var _color: int = 16777215;
        private var _headOnly: Boolean = false;
        private var var_768: Boolean = false;
        private var var_1796: Array;
        private var var_3070: Boolean = false;
        private var _headSprites: Array;
        private var var_3211: Array;
        private var var_3557: Array;
        private var var_4676: int = -1;

        override protected function set direction(param1: int): void {
            if (super.direction != param1) {
                super.direction = param1;
                var_2871 = true;
            }
        }

        override public function dispose(): void {
            var _loc2_: int = 0;
            var _loc1_: AnimationStateData = null;
            super.dispose();
            if (var_1796 != null) {
                _loc2_ = 0;
                while (_loc2_ < var_1796.length) {
                    _loc1_ = var_1796[_loc2_] as AnimationStateData;
                    if (_loc1_ != null) {
                        _loc1_.dispose();
                    }
                    _loc2_++;
                }
                var_1796 = null;
            }
            if (var_2101) {
                var_2101.dispose();
                var_2101 = null;
            }
        }

        override protected function getAnimationId(param1: AnimationStateData): int {
            return param1.animationId;
        }

        override public function initialize(param1: IRoomObjectVisualizationData): Boolean {
            var _loc2_: BitmapDataAsset = null;
            if (!(param1 is AnimatedPetVisualizationData)) {
                return false;
            }
            var_1793 = param1 as AnimatedPetVisualizationData;
            var _loc3_: BitmapData = null;
            if (var_1793.commonAssets != null) {
                _loc2_ = var_1793.commonAssets.getAssetByName("pet_experience_bubble_png") as BitmapDataAsset;
                if (_loc2_ != null) {
                    _loc3_ = (_loc2_.content as BitmapData).clone();
                    var_2101 = new ExperienceData(_loc3_);
                }
            }
            if (super.initialize(param1)) {
                return true;
            }
            return false;
        }

        override public function update(param1: IRoomGeometry, param2: int, param3: Boolean, param4: Boolean): void {
            super.update(param1, param2, param3, param4);
            updateExperienceBubble(param2);
        }

        override protected function updateAnimation(param1: Number): int {
            var _loc3_: int = 0;
            var _loc2_: IRoomObject = object;
            if (_loc2_ != null) {
                _loc3_ = int(_loc2_.getDirection().x);
                if (_loc3_ != var_4676) {
                    var_4676 = _loc3_;
                    resetAllAnimationFrames();
                }
            }
            return super.updateAnimation(param1);
        }

        override protected function updateModel(param1: Number): Boolean {
            var _loc5_: String = null;
            var _loc10_: String = null;
            var _loc11_: Number = NaN;
            var _loc7_: int = 0;
            var _loc2_: Number = NaN;
            var _loc6_: int = 0;
            var _loc8_: Number = NaN;
            var _loc4_: Number = NaN;
            var _loc16_: int = 0;
            var _loc15_: Array = null;
            var _loc12_: Array = null;
            var _loc17_: Array = null;
            var _loc9_: int = 0;
            var _loc3_: Number = NaN;
            var _loc13_: IRoomObject;
            if ((_loc13_ = object) == null) {
                return false;
            }
            var _loc14_: IRoomObjectModel;
            if ((_loc14_ = _loc13_.getModel()) == null) {
                return false;
            }
            if (_loc14_.getUpdateID() != var_1804) {
                _loc5_ = String(_loc14_.getString("figure_posture"));
                _loc10_ = String(_loc14_.getString("figure_gesture"));
                _loc11_ = Number(_loc14_.getNumber("figure_posture"));
                if (!isNaN(_loc11_)) {
                    if ((_loc7_ = var_1793.getPostureCount(var_1755)) > 0) {
                        _loc5_ = var_1793.getPostureForAnimation(var_1755, _loc11_ % _loc7_, true);
                        _loc10_ = null;
                    }
                }
                _loc2_ = Number(_loc14_.getNumber("figure_gesture"));
                if (!isNaN(_loc2_)) {
                    if ((_loc6_ = var_1793.getGestureCount(var_1755)) > 0) {
                        _loc10_ = var_1793.getGestureForAnimation(var_1755, _loc2_ % _loc6_);
                    }
                }
                validateActions(_loc5_, _loc10_);
                _loc8_ = Number(_loc14_.getNumber("furniture_alpha_multiplier"));
                if (isNaN(_loc8_)) {
                    _loc8_ = 1;
                }
                if (_loc8_ != var_2792) {
                    var_2792 = _loc8_;
                    var_2799 = true;
                }
                var_3901 = _loc14_.getNumber("figure_sleep") > 0;
                _loc4_ = Number(_loc14_.getNumber("head_direction"));
                if (!isNaN(_loc4_) && var_1793.isAllowedToTurnHead) {
                    _headDirection = _loc4_;
                } else {
                    _headDirection = _loc13_.getDirection().x;
                }
                var_3598 = _loc14_.getNumber("figure_experience_timestamp");
                var_1365 = _loc14_.getNumber("figure_gained_experience");
                if ((_loc16_ = int(_loc14_.getNumber("pet_palette_index"))) != var_4124) {
                    var_4124 = _loc16_;
                    _paletteName = var_4124.toString();
                }
                var_3097 = (_loc15_ = _loc14_.getNumberArray("pet_custom_layer_ids")) != null ? _loc15_ : [];
                var_3802 = (_loc12_ = _loc14_.getNumberArray("pet_custom_part_ids")) != null ? _loc12_ : [];
                var_3835 = (_loc17_ = _loc14_.getNumberArray("pet_custom_palette_ids")) != null ? _loc17_ : [];
                _loc9_ = int(_loc14_.getNumber("pet_is_riding"));
                var_768 = !isNaN(_loc9_) && _loc9_ > 0;
                _loc3_ = Number(_loc14_.getNumber("pet_color"));
                if (!isNaN(_loc3_) && _loc3_ != _color) {
                    _color = _loc3_;
                }
                _headOnly = _loc14_.getNumber("pet_head_only") > 0;
                var_1804 = _loc14_.getUpdateID();
                return true;
            }
            return false;
        }

        override protected function updateLayerCount(param1: int): void {
            super.updateLayerCount(param1);
            _headSprites = [];
        }

        override protected function getAdditionalSpriteCount(): int {
            return super.getAdditionalSpriteCount() + 1;
        }

        override protected function setAnimation(param1: int): void {
        }

        override protected function resetAllAnimationFrames(): void {
            var _loc2_: int = 0;
            var _loc1_: AnimationStateData = null;
            var_3070 = false;
            _loc2_ = var_1796.length - 1;
            while (_loc2_ >= 0) {
                _loc1_ = var_1796[_loc2_];
                if (_loc1_ != null) {
                    _loc1_.setLayerCount(animatedLayerCount);
                }
                _loc2_--;
            }
        }

        override protected function updateAnimations(param1: Number): int {
            var _loc5_: int = 0;
            var _loc4_: AnimationStateData = null;
            var _loc6_: int = 0;
            if (var_3070) {
                return 0;
            }
            var _loc3_: Boolean = true;
            var _loc2_: * = 0;
            _loc5_ = 0;
            while (_loc5_ < var_1796.length) {
                if ((_loc4_ = var_1796[_loc5_]) != null) {
                    if (!_loc4_.animationOver) {
                        _loc6_ = updateFramesForAnimation(_loc4_, param1);
                        _loc2_ |= _loc6_;
                        if (!_loc4_.animationOver) {
                            _loc3_ = false;
                        } else if (AnimationData.isTransitionFromAnimation(_loc4_.animationId) || AnimationData.isTransitionToAnimation(_loc4_.animationId)) {
                            setAnimationForIndex(_loc5_, _loc4_.animationAfterTransitionId);
                            _loc3_ = false;
                        }
                    }
                }
                _loc5_++;
            }
            var_3070 = _loc3_;
            return _loc2_;
        }

        override protected function getFrameNumber(param1: int, param2: int): int {
            var _loc4_: int = 0;
            var _loc3_: AnimationStateData = null;
            var _loc5_: AnimationFrame = null;
            _loc4_ = var_1796.length - 1;
            while (_loc4_ >= 0) {
                _loc3_ = var_1796[_loc4_];
                if (_loc3_ != null) {
                    if ((_loc5_ = _loc3_.getFrame(param2)) != null) {
                        return _loc5_.id;
                    }
                }
                _loc4_--;
            }
            return super.getFrameNumber(param1, param2);
        }

        override protected function getPostureForAssetFile(param1: int, param2: String): String {
            var _loc5_: int = 0;
            var _loc6_: String = null;
            var _loc4_: Array;
            var _loc3_: int = int((_loc4_ = param2.split("_")).length);
            _loc5_ = 0;
            while (_loc5_ < _loc4_.length) {
                if (_loc4_[_loc5_] == "64" || _loc4_[_loc5_] == "32") {
                    _loc3_ = _loc5_ + 3;
                    break;
                }
                _loc5_++;
            }
            var _loc7_: String = null;
            if (_loc3_ < _loc4_.length) {
                _loc6_ = String((_loc6_ = String(_loc4_[_loc3_])).split("@")[0]);
                if ((_loc7_ = var_1793.getPostureForAnimation(param1, int(_loc6_) / 100, false)) == null) {
                    _loc7_ = var_1793.getGestureForAnimationId(param1, int(_loc6_) / 100);
                }
            }
            return _loc7_;
        }

        override protected function getSpriteXOffset(param1: int, param2: int, param3: int): int {
            var _loc6_: int = 0;
            var _loc5_: AnimationStateData = null;
            var _loc7_: AnimationFrame = null;
            var _loc4_: int = super.getSpriteXOffset(param1, param2, param3);
            _loc6_ = var_1796.length - 1;
            while (_loc6_ >= 0) {
                if ((_loc5_ = var_1796[_loc6_]) != null) {
                    if ((_loc7_ = _loc5_.getFrame(param3)) != null) {
                        _loc4_ += _loc7_.x;
                    }
                }
                _loc6_--;
            }
            return _loc4_;
        }

        override protected function getSpriteYOffset(param1: int, param2: int, param3: int): int {
            var _loc6_: int = 0;
            var _loc5_: AnimationStateData = null;
            var _loc7_: AnimationFrame = null;
            var _loc4_: int = super.getSpriteYOffset(param1, param2, param3);
            _loc6_ = var_1796.length - 1;
            while (_loc6_ >= 0) {
                if ((_loc5_ = var_1796[_loc6_]) != null) {
                    if ((_loc7_ = _loc5_.getFrame(param3)) != null) {
                        _loc4_ += _loc7_.y;
                    }
                }
                _loc6_--;
            }
            return _loc4_;
        }

        override protected function getAsset(param1: String, param2: int = -1): IGraphicAsset {
            var _loc3_: int = 0;
            var _loc5_: String = null;
            var _loc6_: int = 0;
            var _loc7_: int = 0;
            var _loc4_: * = null;
            if (assetCollection != null) {
                _loc3_ = var_3097.indexOf(param2);
                _loc5_ = _paletteName;
                _loc6_ = -1;
                _loc7_ = -1;
                if (_loc3_ > -1) {
                    _loc6_ = int(var_3802[_loc3_]);
                    _loc5_ = (_loc7_ = int(var_3835[_loc3_])) > -1 ? String(_loc7_) : _paletteName;
                }
                if (!isNaN(_loc6_) && _loc6_ > -1) {
                    param1 += "_" + _loc6_;
                }
                return assetCollection.getAssetWithPalette(param1, _loc5_);
            }
            return null;
        }

        override protected function getSpriteZOffset(param1: int, param2: int, param3: int): Number {
            if (var_1793 == null) {
                return 0;
            }
            return var_1793.getZOffset(param1, getDirection(param1, param3), param3);
        }

        override protected function getSpriteAssetName(param1: int, param2: int): String {
            var _loc3_: int = 0;
            var _loc5_: String = null;
            if (_headOnly && isNonHeadSprite(param2)) {
                return null;
            }
            if (var_768 && isSaddleSprite(param2)) {
                return null;
            }
            var _loc4_: int = spriteCount;
            if (param2 < _loc4_ - 1) {
                _loc3_ = getSize(param1);
                if (param2 < _loc4_ - (1 + 1)) {
                    if (param2 >= FurnitureVisualizationData.LAYER_NAMES.length) {
                        return null;
                    }
                    _loc5_ = String(FurnitureVisualizationData.LAYER_NAMES[param2]);
                    if (_loc3_ == 1) {
                        return type + "_icon_" + _loc5_;
                    }
                    return type + "_" + _loc3_ + "_" + _loc5_ + "_" + getDirection(param1, param2) + "_" + getFrameNumber(_loc3_, param2);
                }
                return type + "_" + _loc3_ + "_sd_" + getDirection(param1, param2) + "_0";
            }
            return null;
        }

        override protected function getSpriteColor(param1: int, param2: int, param3: int): int {
            if (param2 < spriteCount - 1) {
                return _color;
            }
            return 16777215;
        }

        private function updateExperienceBubble(param1: int): void {
            var _loc2_: int = 0;
            var _loc3_: IRoomObjectSprite = null;
            if (var_2101 != null) {
                var_2101.alpha = 0;
                if (var_3598 > 0) {
                    _loc2_ = param1 - var_3598;
                    if (_loc2_ < 1000) {
                        var_2101.alpha = Math.sin(_loc2_ / 1000 * 3.141592653589793) * 255;
                        var_2101.setExperience(var_1365);
                    } else {
                        var_3598 = 0;
                    }
                    _loc3_ = getSprite(spriteCount - 1);
                    if (_loc3_ != null) {
                        if (var_2101.alpha > 0) {
                            _loc3_.asset = var_2101.image;
                            _loc3_.offsetX = -20;
                            _loc3_.offsetY = -80;
                            _loc3_.alpha = var_2101.alpha;
                            _loc3_.visible = true;
                        } else {
                            _loc3_.asset = null;
                            _loc3_.visible = false;
                        }
                    }
                }
            }
        }

        private function validateActions(param1: String, param2: String): void {
            var _loc3_: int = 0;
            if (param1 != var_917) {
                var_917 = param1;
                _loc3_ = var_1793.getAnimationForPosture(var_1755, param1);
                setAnimationForIndex(0, _loc3_);
            }
            if (var_1793.getGestureDisabled(var_1755, param1)) {
                param2 = null;
            }
            if (param2 != var_471) {
                var_471 = param2;
                _loc3_ = var_1793.getAnimationForGesture(var_1755, param2);
                setAnimationForIndex(1, _loc3_);
            }
        }

        private function getAnimationStateData(param1: int): AnimationStateData {
            var _loc2_: * = null;
            if (param1 >= 0 && param1 < var_1796.length) {
                return var_1796[param1];
            }
            return null;
        }

        private function setAnimationForIndex(param1: int, param2: int): void {
            var _loc3_: AnimationStateData = getAnimationStateData(param1);
            if (_loc3_ != null) {
                if (setSubAnimation(_loc3_, param2)) {
                    var_3070 = false;
                }
            }
        }

        private function getDirection(param1: int, param2: int): int {
            if (isHeadSprite(param2)) {
                return var_1793.getDirectionValue(param1, _headDirection);
            }
            return direction;
        }

        private function isHeadSprite(param1: int): Boolean {
            var _loc3_: * = false;
            var _loc2_: * = false;
            if (_headSprites[param1] == null) {
                _loc3_ = var_1793.getTag(var_1755, -1, param1) == "head";
                _loc2_ = var_1793.getTag(var_1755, -1, param1) == "hair";
                if (_loc3_ || _loc2_) {
                    _headSprites[param1] = true;
                } else {
                    _headSprites[param1] = false;
                }
            }
            return _headSprites[param1];
        }

        private function isNonHeadSprite(param1: int): Boolean {
            var _loc2_: String = null;
            if (var_3211[param1] == null) {
                if (param1 < spriteCount - (1 + 1)) {
                    _loc2_ = var_1793.getTag(var_1755, -1, param1);
                    if (_loc2_ != null && _loc2_.length > 0 && _loc2_ != "head" && _loc2_ != "hair") {
                        var_3211[param1] = true;
                    } else {
                        var_3211[param1] = false;
                    }
                } else {
                    var_3211[param1] = true;
                }
            }
            return var_3211[param1];
        }

        private function isSaddleSprite(param1: int): Boolean {
            if (var_3557[param1] == null) {
                if (var_1793.getTag(var_1755, -1, param1) == "saddle") {
                    var_3557[param1] = true;
                } else {
                    var_3557[param1] = false;
                }
            }
            return var_3557[param1];
        }
    }
}
