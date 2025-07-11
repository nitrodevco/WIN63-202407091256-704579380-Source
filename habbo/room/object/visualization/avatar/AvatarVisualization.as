package com.sulake.habbo.room.object.visualization.avatar {
    import com.sulake.core.assets.BitmapDataAsset
    import com.sulake.core.assets.IAsset
    import com.sulake.core.utils.Map
    import com.sulake.habbo.avatar.animation.class_3526
    import com.sulake.habbo.avatar.animation.class_3581
    import com.sulake.habbo.avatar.IAvatarImageListener
    import com.sulake.habbo.avatar.class_3374
    import com.sulake.habbo.avatar.class_3375
    import com.sulake.habbo.avatar.enum.class_3584
    import com.sulake.habbo.room.object.visualization.avatar.additions.FloatingIdleZ
    import com.sulake.habbo.room.object.visualization.avatar.additions.GameClickTarget
    import com.sulake.habbo.room.object.visualization.avatar.additions.GuideStatusBubble
    import com.sulake.habbo.room.object.visualization.avatar.additions.MutedBubble
    import com.sulake.habbo.room.object.visualization.avatar.additions.NumberBubble
    import com.sulake.habbo.room.object.visualization.avatar.additions.TypingBubble
    import com.sulake.habbo.room.object.visualization.avatar.additions.class_3545
    import com.sulake.habbo.room.object.visualization.avatar.additions.class_3649
    import com.sulake.habbo.utils.class_3543
    import com.sulake.room.data.RoomObjectSpriteData
    import com.sulake.room.object.IRoomObject
    import com.sulake.room.object.IRoomObjectModel
    import com.sulake.room.object.enum.RoomObjectSpriteType
    import com.sulake.room.object.visualization.IRoomObjectSprite
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization
    import com.sulake.room.utils.IRoomGeometry

    import flash.display.BitmapData
    import flash.filters.BitmapFilter
    import flash.filters.ColorMatrixFilter
    import flash.filters.GlowFilter
    import flash.geom.Point
    import flash.geom.Rectangle

    public class AvatarVisualization extends RoomObjectSpriteVisualization implements IAvatarImageListener, class_3375 {

        private static const AVATAR_SPRITE_TAG: String = "avatar";

        private static const AVATAR_SPRITE_DEFAULT_DEPTH: Number = -0.01;

        private static const AVATAR_OWN_DEPTH_ADJUST: Number = 0.001;

        private static const AVATAR_SPRITE_LAYING_DEPTH: Number = -0.409;

        private static const BASE_Y_SCALE: int = 1000;

        private static const ANIMATION_FRAME_UPDATE_INTERVAL: int = 2;

        private static const DEFAULT_CANVAS_OFFSETS: Array = [0, 0, 0];

        private static const SNOWBOARDING_EFFECT: int = 97;

        private static const FREEZE_EFFECT: int = 218;

        private static const MAX_AVATARS_WITH_EFFECT: int = 3;

        private static const VARIABLE_HOLDER_FILTER: Array = [new ColorMatrixFilter([0.9, 0, 0, 0, 0, 0, 1, 0, 0, 40, 0, 0, 1, 0, 80, 0, 0, 0, 0.85, 0]), new GlowFilter(12318714, 1, 4, 4, 4, 1, true, false)];

        private static const SPRITE_INDEX_AVATAR: int = 0;

        private static const const_738: int = 1;

        private static const INITIAL_RESERVED_SPRITES: int = 2;

        private static const ADDITION_ID_IDLE_BUBBLE: int = 1;

        private static const ADDITION_ID_TYPING_BUBBLE: int = 2;

        private static const ADDITION_ID_EXPRESSION: int = 3;

        private static const ADDITION_ID_NUMBER_BUBBLE: int = 4;

        private static const ADDITION_ID_GAME_CLICK_TARGET: int = 5;

        private static const ADDITION_ID_MUTED_BUBBLE: int = 6;

        private static const ADDITION_ID_GUIDE_STATUS_BUBBLE: int = 7;
        private const const_1048: int = 41;

        public function AvatarVisualization() {
            super();
            _avatars = new Map();
            var_2538 = new Map();
            var_2820 = false;
            var_3272 = Math.random() * 200 + 200;
        }
        private var _lastAnimationUpdateTime: int = -1000;
        private var var_2921: AvatarVisualizationData = null;
        private var _avatars: Map;
        private var var_2538: Map;
        private var _updatesUntilFrameUpdate: int = 0;
        private var var_2820: Boolean;
        private var var_426: String;
        private var var_129: String;
        private var var_3585: int = 0;
        private var _shadowAsset: BitmapDataAsset;
        private var _forceUpdate: Boolean;
        private var var_3272: int;
        private var _headAngle: int = -1;
        private var var_3774: int = -1;
        private var var_4142: int = -1;
        private var var_3977: int = 2;
        private var var_1800: Map;
        private var var_3848: int = -1;
        private var var_917: String = "";
        private var var_3899: String = "";
        private var var_4096: Boolean = false;
        private var var_3901: Boolean = false;
        private var var_3574: Boolean = false;
        private var var_404: int = 0;
        private var var_471: int = 0;
        private var var_1021: int = 0;
        private var var_3822: int = 0;
        private var var_4159: Boolean = false;
        private var var_3676: Boolean = false;
        private var var_3948: int = -1;
        private var var_2531: int = 0;
        private var var_2762: int = 0;
        private var var_2340: int = 0;
        private var _geometryOffset: int = 0;
        private var var_3727: int = 0;
        private var var_2688: Boolean = false;
        private var var_2814: Boolean = false;
        private var var_3635: Boolean = false;
        private var var_1668: class_3374 = null;
        private var var_4214: Boolean = false;
        private var var_318: Boolean;

        public function get disposed(): Boolean {
            return var_318;
        }

        public function get angle(): int {
            return var_3774;
        }

        public function get posture(): String {
            return var_917;
        }

        protected function get numAdditions(): int {
            return !!var_1800 ? var_1800.length : 0;
        }

        override public function dispose(): void {
            if (_avatars != null) {
                resetImages();
                _avatars.dispose();
                var_2538.dispose();
                _avatars = null;
            }
            var_2921 = null;
            _shadowAsset = null;
            if (var_1800) {
                for each(var _loc1_ in var_1800) {
                    _loc1_.dispose();
                }
                var_1800 = null;
            }
            super.dispose();
            var_318 = true;
        }

        override public function getSpriteList(): Array {
            var _loc17_: RoomObjectSpriteData = null;
            var _loc6_: RoomObjectSpriteData = null;
            var _loc11_: class_3526 = null;
            var _loc18_: int = 0;
            var _loc1_: int = 0;
            var _loc13_: int = 0;
            var _loc14_: int = 0;
            var _loc15_: int = 0;
            var _loc19_: * = 0;
            var _loc8_: int = 0;
            var _loc7_: String = null;
            var _loc2_: BitmapDataAsset = null;
            var _loc12_: Rectangle = null;
            var _loc5_: String = null;
            if (var_1668 == null) {
                return null;
            }
            var _loc3_: IRoomObjectSprite = getSprite(1);
            if (_loc3_) {
                (_loc17_ = new RoomObjectSpriteData()).alpha = _loc3_.alpha;
                _loc17_.x = _loc3_.offsetX;
                _loc17_.y = _loc3_.offsetY;
                _loc17_.name = _loc3_.assetName;
                _loc17_.width = _loc3_.width;
                _loc17_.height = _loc3_.height;
            }
            var _loc9_: Array = var_1668.getServerRenderData();
            for each(var _loc10_ in var_1668.getSprites()) {
                _loc6_ = new RoomObjectSpriteData();
                _loc11_ = var_1668.getLayerData(_loc10_);
                _loc18_ = 0;
                _loc1_ = var_1668.getDirection();
                _loc13_ = _loc10_.getDirectionOffsetX(_loc1_);
                _loc14_ = _loc10_.getDirectionOffsetY(_loc1_);
                _loc15_ = _loc10_.getDirectionOffsetZ(_loc1_);
                _loc19_ = 0;
                if (_loc10_.hasDirections) {
                    _loc19_ = _loc1_;
                }
                if (_loc11_ != null) {
                    _loc18_ = _loc11_.animationFrame;
                    _loc13_ += _loc11_.dx;
                    _loc14_ += _loc11_.dy;
                    _loc19_ += _loc11_.directionOffset;
                }
                if ((_loc8_ = 64) < 48) {
                    _loc13_ /= 2;
                    _loc14_ /= 2;
                }
                if (_loc19_ < 0) {
                    _loc19_ += 8;
                } else if (_loc19_ > 7) {
                    _loc19_ -= 8;
                }
                _loc7_ = var_1668.getScale() + "_" + _loc10_.member + "_" + _loc19_ + "_" + _loc18_;
                _loc2_ = var_1668.getAsset(_loc7_);
                if (_loc2_ != null) {
                    _loc6_.x = -_loc2_.offset.x - _loc8_ / 2 + _loc13_;
                    _loc6_.y = -_loc2_.offset.y + _loc14_;
                    if (_loc10_.hasStaticY) {
                        _loc6_.y += var_3727 * _loc8_ / (2 * 1000);
                    }
                    if (_loc10_.ink == 33) {
                        _loc6_.blendMode = "add";
                    }
                    _loc6_.name = _loc7_;
                    if (var_2814) {
                        _loc6_.z = -0.409 - 0.001 * spriteCount * _loc15_;
                    } else {
                        _loc6_.z = -0.001 * spriteCount * _loc15_;
                    }
                    if ((_loc12_ = _loc2_.rectangle) == null) {
                        _loc6_.width = 60;
                        _loc6_.height = 60;
                    } else {
                        _loc6_.width = _loc12_.width;
                        _loc6_.height = _loc12_.height;
                    }
                    _loc9_.push(_loc6_);
                }
            }
            var _loc4_: class_3581;
            if ((_loc4_ = var_1668.avatarSpriteData) != null && _loc4_.paletteIsGrayscale) {
                _loc5_ = String(_loc4_.reds[0].toString());
                for each(var _loc16_ in _loc9_) {
                    if (_loc16_.name.indexOf("h_std_fx") == -1 && _loc16_.name.indexOf("h_std_sd") == -1) {
                        _loc16_.color = _loc5_;
                    }
                }
            }
            if (_loc17_) {
                _loc9_.push(_loc17_);
            }
            return _loc9_;
        }

        override public function initialize(param1: IRoomObjectVisualizationData): Boolean {
            var_2921 = param1 as AvatarVisualizationData;
            createSprites(2);
            return true;
        }

        override public function update(param1: IRoomGeometry, param2: int, param3: Boolean, param4: Boolean): void {
            var _loc5_: int = 0;
            var _loc10_: IRoomObjectSprite = null;
            var _loc22_: IRoomObjectSprite = null;
            var _loc18_: Array = null;
            var _loc26_: BitmapData = null;
            var _loc35_: BitmapFilter = null;
            var _loc33_: int = 0;
            var _loc27_: int = 0;
            var _loc28_: class_3526 = null;
            var _loc13_: int = 0;
            var _loc12_: int = 0;
            var _loc16_: class_3526 = null;
            var _loc41_: int = 0;
            var _loc17_: int = 0;
            var _loc19_: int = 0;
            var _loc21_: int = 0;
            var _loc25_: * = 0;
            var _loc30_: String = null;
            var _loc6_: BitmapDataAsset = null;
            var _loc31_: int = 0;
            var _loc8_: Boolean = false;
            var _loc37_: int = 0;
            var _loc36_: int = 0;
            var _loc38_: IRoomObject;
            if ((_loc38_ = object) == null) {
                return;
            }
            if (param1 == null) {
                return;
            }
            if (var_2921 == null) {
                return;
            }
            if (--var_3272 <= 0 && var_1668) {
                var_1668.disposeInactiveActionCache();
                var_3272 = 500;
            }
            var _loc15_: *;
            if (_loc15_ = param2 >= _lastAnimationUpdateTime + 41) {
                _lastAnimationUpdateTime += 41;
                if (_lastAnimationUpdateTime + 41 < param2) {
                    _lastAnimationUpdateTime = param2 - 41;
                }
            }
            var _loc23_: IRoomObjectModel = _loc38_.getModel();
            var _loc11_: Number = param1.scale;
            var _loc7_: Boolean = false;
            var _loc20_: Boolean = false;
            var _loc9_: Boolean = false;
            var _loc34_: int = var_2531;
            var _loc40_: Boolean = false;
            var _loc32_: Boolean = updateModel(_loc23_, _loc11_, param3);
            if (_forceUpdate) {
                resetImages();
                _forceUpdate = false;
            }
            if (_loc32_ || _loc11_ != var_1755 || var_1668 == null) {
                if (_loc11_ != var_1755) {
                    _loc20_ = true;
                    validateActions(_loc11_);
                }
                if (_loc34_ != var_2531) {
                    _loc40_ = true;
                }
                if (_loc20_ || var_1668 == null || _loc40_) {
                    var_1668 = getAvatarImage(_loc11_, var_2531);
                    if (var_1668 == null) {
                        return;
                    }
                    _loc7_ = true;
                    if ((_loc10_ = getSprite(0)) && var_1668 && var_1668.isPlaceholder()) {
                        _loc10_.alpha = 150;
                    } else if (_loc10_) {
                        _loc10_.alpha = 255;
                    }
                }
                if (var_1668 == null) {
                    return;
                }
                if (_loc40_ && var_1668.animationHasResetOnToggle) {
                    var_1668.resetAnimationFrameCounter();
                }
                updateShadow(_loc11_);
                _loc9_ = updateObject(_loc38_, param1, param3, true);
                updateActions(var_1668);
                if (var_1800) {
                    _loc5_ = var_3977;
                    for each(var _loc24_ in var_1800) {
                        _loc24_.update(getSprite(_loc5_++), _loc11_);
                    }
                }
                var_1755 = _loc11_;
            } else {
                _loc9_ = updateObject(_loc38_, param1, param3);
            }
            if (_loc15_ && var_1800) {
                _loc5_ = var_3977;
                for each(_loc24_ in var_1800) {
                    if (_loc24_.animate(getSprite(_loc5_++))) {
                        increaseUpdateId();
                    }
                }
            }
            var _loc39_: Boolean = _loc9_ || _loc32_ || _loc20_;
            var _loc29_: Boolean = (var_2820 || var_3585 > 0) && param3 && _loc15_;
            if (_loc39_) {
                var_3585 = 2;
            }
            if (_loc39_ || _loc29_) {
                increaseUpdateId();
                if (_loc15_) {
                    var_3585--;
                    _updatesUntilFrameUpdate--;
                }
                if (!(_updatesUntilFrameUpdate <= 0 || _loc20_ || _loc32_ || _loc7_)) {
                    return;
                }
                var_1668.updateAnimationByFrames(1);
                _updatesUntilFrameUpdate = 2;
                if ((_loc18_ = var_1668.getCanvasOffsets()) == null || _loc18_.length < 3) {
                    _loc18_ = DEFAULT_CANVAS_OFFSETS;
                }
                if ((_loc22_ = getSprite(0)) != null) {
                    if ((_loc26_ = var_1668.getImage("full", var_3822 || var_3676)) != null) {
                        if (var_3822) {
                            _loc35_ = new GlowFilter(16777215, 1, 6, 6);
                            _loc26_.applyFilter(_loc26_, _loc26_.rect, new Point(0, 0), _loc35_);
                        } else if (var_3676) {
                            for each(_loc35_ in VARIABLE_HOLDER_FILTER) {
                                _loc26_.applyFilter(_loc26_, _loc26_.rect, new Point(0, 0), _loc35_);
                            }
                        }
                        _loc22_.asset = _loc26_;
                    }
                    if (_loc22_.asset) {
                        _loc22_.offsetX = -1 * _loc11_ / 2 + _loc18_[0] - (_loc22_.asset.width - _loc11_) / 2;
                        _loc22_.offsetY = -_loc22_.asset.height + _loc11_ / 4 + _loc18_[1] + _geometryOffset;
                        if (var_917 == "swdieback" || var_917 == "swdiefront") {
                            _loc22_.offsetY += 20 * _loc11_ / 32;
                        }
                    }
                    if (var_2814) {
                        if (var_3635) {
                            _loc22_.relativeDepth = -0.5;
                        } else {
                            _loc22_.relativeDepth = -0.409 + _loc18_[2];
                        }
                    } else {
                        _loc22_.relativeDepth = -0.01 + _loc18_[2];
                    }
                    if (var_4214) {
                        _loc22_.relativeDepth -= 0.001;
                        _loc22_.spriteType = RoomObjectSpriteType.var_4442;
                    } else {
                        _loc22_.spriteType = RoomObjectSpriteType.AVATAR;
                    }
                }
                if (_loc24_ = getAddition(2) as TypingBubble) {
                    if (!var_2814) {
                        TypingBubble(_loc24_).relativeDepth = -0.01 - 0.01 + _loc18_[2];
                    } else {
                        TypingBubble(_loc24_).relativeDepth = -0.409 - 0.01 + _loc18_[2];
                    }
                }
                var_2820 = var_1668.isAnimating();
                _loc33_ = 2;
                _loc27_ = var_1668.getDirection();
                for each(var _loc14_ in var_1668.getSprites()) {
                    if (_loc14_.id == "avatar") {
                        _loc22_ = getSprite(0);
                        _loc28_ = var_1668.getLayerData(_loc14_);
                        _loc13_ = _loc14_.getDirectionOffsetX(_loc27_);
                        _loc12_ = _loc14_.getDirectionOffsetY(_loc27_);
                        if (_loc28_ != null) {
                            _loc13_ += _loc28_.dx;
                            _loc12_ += _loc28_.dy;
                        }
                        if (_loc11_ < 48) {
                            _loc13_ /= 2;
                            _loc12_ /= 2;
                        }
                        if (!var_2688) {
                            _loc22_.offsetX += _loc13_;
                            _loc22_.offsetY += _loc12_;
                        }
                    } else {
                        if ((_loc22_ = getSprite(_loc33_)) != null) {
                            _loc22_.alphaTolerance = 256;
                            _loc22_.visible = true;
                            _loc16_ = var_1668.getLayerData(_loc14_);
                            _loc41_ = 0;
                            _loc17_ = _loc14_.getDirectionOffsetX(_loc27_);
                            _loc19_ = _loc14_.getDirectionOffsetY(_loc27_);
                            _loc21_ = _loc14_.getDirectionOffsetZ(_loc27_);
                            _loc25_ = 0;
                            if (_loc14_.hasDirections) {
                                _loc25_ = _loc27_;
                            }
                            if (_loc16_ != null) {
                                _loc41_ = _loc16_.animationFrame;
                                _loc17_ += _loc16_.dx;
                                _loc19_ += _loc16_.dy;
                                _loc25_ += _loc16_.directionOffset;
                            }
                            if (_loc11_ < 48) {
                                _loc17_ /= 2;
                                _loc19_ /= 2;
                            }
                            if (_loc25_ < 0) {
                                _loc25_ += 8;
                            } else if (_loc25_ > 7) {
                                _loc25_ -= 8;
                            }
                            _loc30_ = var_1668.getScale() + "_" + _loc14_.member + "_" + _loc25_ + "_" + _loc41_;
                            _loc6_ = var_1668.getAsset(_loc30_);
                            _loc31_ = var_1668.getScale() == "sh" ? 32 : 64;
                            _loc8_ = false;
                            if (_loc6_ == null) {
                                if (var_1668.getScale() == "sh") {
                                    _loc30_ = "h_" + _loc14_.member + "_" + _loc25_ + "_" + _loc41_;
                                    _loc6_ = var_1668.getAsset(_loc30_);
                                    _loc8_ = true;
                                }
                                if (_loc6_ == null) {
                                    continue;
                                }
                            }
                            _loc22_.asset = _loc8_ ? class_3543.resampleBitmapData(_loc6_.content as BitmapData, 0.5) : _loc6_.content as BitmapData;
                            _loc37_ = _loc8_ ? _loc6_.offset.x / 2 : _loc6_.offset.x;
                            _loc36_ = _loc8_ ? _loc6_.offset.y / 2 : _loc6_.offset.y;
                            _loc22_.offsetX = -_loc37_ - _loc31_ / 2 + _loc17_;
                            _loc22_.offsetY = -_loc36_ + _loc19_;
                            if (_loc14_.hasStaticY) {
                                _loc22_.offsetY += var_3727 * _loc11_ / (2 * 1000);
                            } else {
                                _loc22_.offsetY += _geometryOffset;
                            }
                            if (var_2814) {
                                _loc22_.relativeDepth = -0.409 - 0.001 * spriteCount * _loc21_;
                            } else {
                                _loc22_.relativeDepth = -0.01 - 0.001 * spriteCount * _loc21_;
                            }
                            if (_loc14_.ink == 33) {
                                _loc22_.blendMode = "add";
                            } else {
                                _loc22_.blendMode = "normal";
                            }
                        }
                        _loc33_++;
                    }
                }
            }
        }

        public function getAvatarRendererAsset(param1: String): IAsset {
            return !!var_2921 ? var_2921.getAvatarRendererAsset(param1) : null;
        }

        public function avatarImageReady(param1: String): void {
            _forceUpdate = true;
        }

        public function avatarEffectReady(param1: int): void {
            _forceUpdate = true;
        }

        public function addAddition(param1: class_3545): class_3545 {
            if (!var_1800) {
                var_1800 = new Map();
            }
            if (var_1800.hasKey(param1.id)) {
                throw new Error("Avatar addition with index " + param1.id + "already exists!");
            }
            var_1800.add(param1.id, param1);
            return param1;
        }

        public function getAddition(param1: int): class_3545 {
            return !!var_1800 ? var_1800[param1] : null;
        }

        public function removeAddition(param1: int): void {
            var _loc2_: class_3545 = getAddition(param1);
            if (!_loc2_) {
                return;
            }
            var_1800.remove(param1);
            _loc2_.dispose();
        }

        private function updateModel(param1: IRoomObjectModel, param2: Number, param3: Boolean): Boolean {
            var _loc7_: Boolean = false;
            var _loc4_: * = false;
            var _loc8_: int = 0;
            var _loc6_: String = null;
            var _loc9_: class_3545 = null;
            var _loc5_: String = null;
            if (param1.getUpdateID() != var_1804) {
                _loc7_ = false;
                _loc4_ = false;
                _loc8_ = 0;
                _loc6_ = "";
                if ((_loc4_ = param1.getNumber("figure_talk") > 0 && param3) != var_4096) {
                    var_4096 = _loc4_;
                    _loc7_ = true;
                }
                if ((_loc8_ = int(param1.getNumber("figure_expression"))) != var_404) {
                    var_404 = _loc8_;
                    _loc7_ = true;
                }
                if ((_loc4_ = param1.getNumber("figure_sleep") > 0) != var_3901) {
                    var_3901 = _loc4_;
                    _loc7_ = true;
                }
                if ((_loc4_ = param1.getNumber("figure_blink") > 0 && param3) != var_3574) {
                    var_3574 = _loc4_;
                    _loc7_ = true;
                }
                if ((_loc8_ = int(param1.getNumber("figure_gesture"))) != var_471) {
                    var_471 = _loc8_;
                    _loc7_ = true;
                }
                if ((_loc6_ = String(param1.getString("figure_posture"))) != var_917) {
                    var_917 = _loc6_;
                    _loc7_ = true;
                }
                if ((_loc6_ = String(param1.getString("figure_posture_parameter"))) != var_3899) {
                    var_3899 = _loc6_;
                    _loc7_ = true;
                }
                if ((_loc4_ = param1.getNumber("figure_can_stand_up") > 0) != var_2688) {
                    var_2688 = _loc4_;
                    _loc7_ = true;
                }
                if ((_loc8_ = param1.getNumber("figure_vertical_offset") * 1000) != var_3727) {
                    var_3727 = _loc8_;
                    _loc7_ = true;
                }
                if ((_loc8_ = int(param1.getNumber("figure_dance"))) != var_1021) {
                    var_1021 = _loc8_;
                    _loc7_ = true;
                }
                if ((_loc8_ = int(param1.getNumber("figure_effect"))) != var_2531) {
                    var_2531 = _loc8_;
                    _loc7_ = true;
                }
                if ((_loc8_ = int(param1.getNumber("figure_carry_object"))) != var_2762) {
                    var_2762 = _loc8_;
                    _loc7_ = true;
                }
                if ((_loc8_ = int(param1.getNumber("figure_use_object"))) != var_2340) {
                    var_2340 = _loc8_;
                    _loc7_ = true;
                }
                if ((_loc8_ = int(param1.getNumber("head_direction"))) != _headAngle) {
                    _headAngle = _loc8_;
                    _loc7_ = true;
                }
                if (var_2762 > 0 && param1.getNumber("figure_use_object") > 0) {
                    if (var_2340 != var_2762) {
                        var_2340 = var_2762;
                        _loc7_ = true;
                    }
                } else if (var_2340 != 0) {
                    var_2340 = 0;
                    _loc7_ = true;
                }
                _loc9_ = getAddition(1) as FloatingIdleZ;
                if (var_3901) {
                    if (!_loc9_) {
                        _loc9_ = addAddition(new FloatingIdleZ(1, this));
                    }
                    _loc7_ = true;
                } else if (_loc9_) {
                    removeAddition(1);
                }
                _loc4_ = param1.getNumber("figure_is_muted") > 0;
                _loc9_ = getAddition(6) as MutedBubble;
                if (_loc4_) {
                    if (!_loc9_) {
                        _loc9_ = addAddition(new MutedBubble(6, this));
                    }
                    removeAddition(2);
                    _loc7_ = true;
                } else {
                    if (_loc9_) {
                        removeAddition(6);
                        _loc7_ = true;
                    }
                    _loc4_ = param1.getNumber("figure_is_typing") > 0;
                    _loc9_ = getAddition(2) as TypingBubble;
                    if (_loc4_) {
                        if (!_loc9_) {
                            _loc9_ = addAddition(new TypingBubble(2, this));
                        }
                        _loc7_ = true;
                    } else if (_loc9_) {
                        removeAddition(2);
                    }
                }
                if ((_loc8_ = int(param1.getNumber("figure_guide_status"))) != 0) {
                    removeAddition(7);
                    addAddition(new GuideStatusBubble(7, this, _loc8_));
                    _loc7_ = true;
                } else if (getAddition(7) as GuideStatusBubble != null) {
                    removeAddition(7);
                    _loc7_ = true;
                }
                _loc4_ = param1.getNumber("figure_is_playing_game") > 0;
                _loc9_ = getAddition(5) as GameClickTarget;
                if (_loc4_) {
                    if (!_loc9_) {
                        _loc9_ = addAddition(new GameClickTarget(5));
                    }
                    _loc7_ = true;
                } else if (_loc9_) {
                    removeAddition(5);
                }
                _loc8_ = int(param1.getNumber("figure_number_value"));
                _loc9_ = getAddition(4) as NumberBubble;
                if (_loc8_ > 0) {
                    if (!_loc9_) {
                        _loc9_ = addAddition(new NumberBubble(4, _loc8_, this));
                    }
                    _loc7_ = true;
                } else if (_loc9_) {
                    removeAddition(4);
                }
                _loc8_ = int(param1.getNumber("figure_expression"));
                _loc9_ = getAddition(3);
                if (_loc8_ > 0) {
                    if (!_loc9_) {
                        if (_loc9_ = class_3649.make(3, _loc8_, this)) {
                            addAddition(_loc9_);
                        }
                    }
                } else if (_loc9_) {
                    removeAddition(3);
                }
                validateActions(param2);
                if ((_loc6_ = String(param1.getString("gender"))) != var_129) {
                    var_129 = _loc6_;
                    _loc7_ = true;
                }
                _loc5_ = String(param1.getString("figure"));
                if (updateFigure(_loc5_)) {
                    _loc7_ = true;
                }
                if (param1.hasNumber("figure_sign")) {
                    if ((_loc8_ = int(param1.getNumber("figure_sign"))) != var_3948) {
                        _loc7_ = true;
                        var_3948 = _loc8_;
                    }
                }
                if ((_loc4_ = param1.getNumber("figure_highlight_enable") > 0) != var_4159) {
                    var_4159 = _loc4_;
                    _loc7_ = true;
                }
                if (var_4159) {
                    if ((_loc8_ = int(param1.getNumber("figure_highlight"))) != var_3822) {
                        var_3822 = _loc8_;
                        _loc7_ = true;
                    }
                }
                if ((_loc4_ = param1.getNumber("figure_highlight_variable_holder") > 0) != var_3676) {
                    var_3676 = _loc4_;
                    _loc7_ = true;
                }
                if ((_loc4_ = param1.getNumber("own_user") > 0) != var_4214) {
                    var_4214 = _loc4_;
                    _loc7_ = true;
                }
                var_1804 = param1.getUpdateID();
                return _loc7_;
            }
            return false;
        }

        private function updateFigure(param1: String): Boolean {
            if (var_426 != param1) {
                var_426 = param1;
                resetImages();
                return true;
            }
            return false;
        }

        private function resetImages(): void {
            var _loc2_: * = null;
            for each(_loc2_ in _avatars) {
                if (_loc2_) {
                    _loc2_.dispose();
                }
            }
            for each(_loc2_ in var_2538) {
                if (_loc2_) {
                    _loc2_.dispose();
                }
            }
            _avatars.reset();
            var_2538.reset();
            var_1668 = null;
            var _loc1_: IRoomObjectSprite = getSprite(0);
            if (_loc1_ != null) {
                _loc1_.asset = null;
                _loc1_.alpha = 255;
            }
        }

        private function validateActions(param1: Number): void {
            var _loc2_: int = 0;
            if (param1 < 48) {
                var_3574 = false;
            }
            if (var_917 == "sit" || var_917 == "lay") {
                _geometryOffset = param1 / 2;
            } else {
                _geometryOffset = 0;
            }
            var_3635 = false;
            var_2814 = false;
            if (var_917 == "lay") {
                var_2814 = true;
                _loc2_ = int(var_3899);
                if (_loc2_ < 0) {
                    var_3635 = true;
                }
            }
        }

        private function getAvatarImage(param1: Number, param2: int): class_3374 {
            var _loc4_: class_3374 = null;
            var _loc5_: class_3374 = null;
            var _loc3_: String = "avatarImage" + param1.toString();
            if (param2 == 0) {
                _loc4_ = _avatars.getValue(_loc3_) as class_3374;
            } else {
                _loc3_ += "-" + param2;
                if (_loc4_ = var_2538.getValue(_loc3_) as class_3374) {
                    _loc4_.forceActionUpdate();
                }
            }
            if (_loc4_ == null) {
                if ((_loc4_ = var_2921.getAvatar(var_426, param1, var_129, this, this)) != null) {
                    if (param2 == 0) {
                        _avatars.add(_loc3_, _loc4_);
                    } else {
                        if (var_2538.length >= 3) {
                            if (_loc5_ = var_2538.remove(var_2538.getKey(0))) {
                                _loc5_.dispose();
                            }
                        }
                        var_2538.add(_loc3_, _loc4_);
                    }
                }
            }
            return _loc4_;
        }

        private function updateObject(param1: IRoomObject, param2: IRoomGeometry, param3: Boolean, param4: Boolean = false): Boolean {
            var _loc6_: * = false;
            var _loc5_: int = 0;
            var _loc7_: * = 0;
            if (param4 || var_2880 != param1.getUpdateID() || var_3848 != param2.updateId) {
                _loc6_ = param3;
                _loc5_ = ((_loc5_ = param1.getDirection().x - param2.direction.x) % 360 + 360) % 360;
                if (var_917 == "sit" && var_2688) {
                    _loc5_ -= _loc5_ % 90 - 45;
                }
                _loc7_ = _headAngle;
                if (var_917 == "float") {
                    _loc7_ = _loc5_;
                } else {
                    _loc7_ -= param2.direction.x;
                }
                _loc7_ = (_loc7_ % 360 + 360) % 360;
                if (var_917 == "sit" && var_2688 || var_917 == "swdieback" || var_917 == "swdiefront") {
                    _loc7_ -= _loc7_ % 90 - 45;
                }
                if (_loc5_ != var_3774 || param4) {
                    _loc6_ = true;
                    var_3774 = _loc5_;
                    _loc5_ = ((_loc5_ -= 112.5) + 360) % 360;
                    var_1668.setDirectionAngle("full", _loc5_);
                }
                if (_loc7_ != var_4142 || param4) {
                    _loc6_ = true;
                    var_4142 = _loc7_;
                    if (var_4142 != var_3774) {
                        _loc7_ = ((_loc7_ -= 112.5) + 360) % 360;
                        var_1668.setDirectionAngle("head", _loc7_);
                    }
                }
                var_2880 = param1.getUpdateID();
                var_3848 = param2.updateId;
                return _loc6_;
            }
            return false;
        }

        private function updateShadow(param1: Number): void {
            var _loc2_: int = 0;
            var _loc3_: int = 0;
            var _loc5_: IRoomObjectSprite = getSprite(1);
            _shadowAsset = null;
            var _loc4_: Boolean = var_917 == "mv" || var_917 == "std" || var_917 == "sit" && var_2688;
            if (var_2531 == 97 || var_2531 == 218) {
                _loc4_ = false;
            }
            if (_loc4_) {
                _loc5_.visible = true;
                if (_shadowAsset == null || param1 != var_1755) {
                    _loc2_ = 0;
                    _loc3_ = 0;
                    if (param1 < 48) {
                        _loc5_.libraryAssetName = "sh_std_sd_1_0_0";
                        _shadowAsset = var_1668.getAsset(_loc5_.libraryAssetName);
                        _loc2_ = -8;
                        _loc3_ = var_2688 ? 6 : -3;
                    } else {
                        _loc5_.libraryAssetName = "h_std_sd_1_0_0";
                        _shadowAsset = var_1668.getAsset(_loc5_.libraryAssetName);
                        _loc2_ = -17;
                        _loc3_ = var_2688 ? 10 : -7;
                    }
                    if (_shadowAsset != null) {
                        _loc5_.asset = _shadowAsset.content as BitmapData;
                        _loc5_.offsetX = _loc2_;
                        _loc5_.offsetY = _loc3_;
                        _loc5_.alpha = 50;
                        _loc5_.relativeDepth = 1;
                    } else {
                        _loc5_.visible = false;
                    }
                }
            } else {
                _shadowAsset = null;
                _loc5_.visible = false;
            }
        }

        private function updateActions(param1: class_3374): void {
            var _loc3_: String = null;
            var _loc5_: IRoomObjectSprite = null;
            if (param1 == null) {
                return;
            }
            param1.initActionAppends();
            param1.appendAction("posture", var_917, var_3899);
            if (var_471 > 0) {
                param1.appendAction("gest", class_3584.getGesture(var_471));
            }
            if (var_1021 > 0) {
                param1.appendAction("dance", var_1021);
            }
            if (var_3948 > -1) {
                param1.appendAction("sign", var_3948);
            }
            if (var_2762 > 0) {
                param1.appendAction("cri", var_2762);
            }
            if (var_2340 > 0) {
                param1.appendAction("usei", var_2340);
            }
            if (var_4096) {
                param1.appendAction("talk");
            }
            if (var_3901 || var_3574) {
                param1.appendAction("Sleep");
            }
            if (var_404 > 0) {
                _loc3_ = class_3584.getExpression(var_404);
                if (_loc3_ != "") {
                    var _loc7_: * = _loc3_;
                    if ("dance" !== _loc7_) {
                        param1.appendAction(_loc3_);
                    } else {
                        param1.appendAction("dance", 2);
                    }
                }
            }
            if (var_2531 > 0) {
                param1.appendAction("fx", var_2531);
            }
            param1.endActionAppends();
            var_2820 = param1.isAnimating();
            var _loc2_: int = 2;
            for each(var _loc4_ in var_1668.getSprites()) {
                if (_loc4_.id != "avatar") {
                    _loc2_++;
                }
            }
            if (_loc2_ != spriteCount) {
                createSprites(_loc2_);
            }
            var_3977 = _loc2_;
            if (var_1800) {
                for each(var _loc6_ in var_1800) {
                    _loc5_ = addSprite();
                }
            }
        }
    }
}
