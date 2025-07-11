package com.sulake.habbo.room.object.logic {
    import com.sulake.habbo.avatar.enum.class_3584
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent
    import com.sulake.habbo.room.events.RoomObjectMoveEvent
    import com.sulake.habbo.room.messages.RoomObjectAvatarCarryObjectUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarDanceUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarDirectionUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarEffectUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarExpressionUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarFlatControlUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarGestureUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarGuideStatusUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarMutedUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarOwnMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarPlayerValueUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarPlayingGameMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarSelectedMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarSignUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarTypingUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage
    import com.sulake.habbo.room.messages.RoomObjectAvatarUseObjectUpdateMessage
    import com.sulake.room.events.RoomObjectEvent
    import com.sulake.room.events.RoomObjectMouseEvent
    import com.sulake.room.events.RoomSpriteMouseEvent
    import com.sulake.room.messages.RoomObjectUpdateMessage
    import com.sulake.room.object.IRoomObjectModelController
    import com.sulake.room.utils.IRoomGeometry
    import com.sulake.room.utils.IVector3d
    import com.sulake.room.utils.Vector3d

    import flash.utils.getTimer

    public class AvatarLogic extends MovingObjectLogic {

        private static const const_899: Number = 1.5;

        private static const EFFECT_TYPE_SPLASH: int = 28;

        private static const EFFECT_TYPE_SWIM: int = 29;

        private static const const_736: int = 184;

        private static const const_921: int = 185;

        private static const EFFECT_SPLASH_LENGTH: int = 500;

        private static const CARRY_ITEM_NULL: int = 0;

        private static const CARRY_ITEM_LAST_CONSUMABLE: int = 999;

        private static const CARRY_ITEM_EMPTY_HAND: int = 999999999;

        private static const CARRY_ITEM_DELAY_BEFORE_USE: int = 5000;

        private static const CARRY_ITEM_EMPTY_HAND_ANIMATION_LENGTH: int = 1500;

        public function AvatarLogic() {
            super();
            var_3828 = getTimer() + getBlinkInterval();
        }
        private var _selected: Boolean = false;
        private var var_2242: Vector3d = null;
        private var var_1960: int = 0;
        private var var_2299: int = 0;
        private var var_3405: int = 0;
        private var var_2644: int = 0;
        private var var_2515: int = 0;
        private var var_2462: int = 0;
        private var var_3479: int = 0;
        private var var_3400: int = 0;
        private var var_3072: int = 0;
        private var var_2892: int = 0;
        private var _allowUseCarryObject: Boolean = false;
        private var var_3486: int = 0;
        private var var_3828: int = 0;
        private var var_3520: int = 0;

        override public function getEventTypes(): Array {
            var _loc1_: Array = ["ROE_MOUSE_CLICK", "ROME_POSITION_CHANGED", "ROE_MOUSE_ENTER", "ROE_MOUSE_LEAVE", "ROFCAE_MOUSE_BUTTON", "ROFCAE_MOUSE_ARROW"];
            return getAllEventTypes(super.getEventTypes(), _loc1_);
        }

        override public function dispose(): void {
            var _loc1_: RoomObjectEvent = null;
            if (_selected && object != null) {
                if (eventDispatcher != null) {
                    _loc1_ = new RoomObjectMoveEvent("ROME_OBJECT_REMOVED", object);
                    eventDispatcher.dispatchEvent(_loc1_);
                }
            }
            super.dispose();
            var_2242 = null;
        }

        override public function processUpdateMessage(param1: RoomObjectUpdateMessage): void {
            var _loc10_: RoomObjectAvatarPostureUpdateMessage = null;
            var _loc22_: RoomObjectAvatarChatUpdateMessage = null;
            var _loc26_: RoomObjectAvatarTypingUpdateMessage = null;
            var _loc11_: RoomObjectAvatarMutedUpdateMessage = null;
            var _loc2_: RoomObjectAvatarPlayingGameMessage = null;
            var _loc18_: RoomObjectAvatarUpdateMessage = null;
            var _loc27_: RoomObjectAvatarDirectionUpdateMessage = null;
            var _loc17_: RoomObjectAvatarGestureUpdateMessage = null;
            var _loc12_: RoomObjectAvatarDanceUpdateMessage = null;
            var _loc13_: RoomObjectAvatarSleepUpdateMessage = null;
            var _loc23_: RoomObjectAvatarPlayerValueUpdateMessage = null;
            var _loc4_: RoomObjectAvatarEffectUpdateMessage = null;
            var _loc25_: int = 0;
            var _loc9_: int = 0;
            var _loc24_: RoomObjectAvatarCarryObjectUpdateMessage = null;
            var _loc7_: RoomObjectAvatarUseObjectUpdateMessage = null;
            var _loc5_: RoomObjectAvatarSignUpdateMessage = null;
            var _loc20_: RoomObjectAvatarFlatControlUpdateMessage = null;
            var _loc21_: Number = NaN;
            var _loc15_: RoomObjectAvatarFigureUpdateMessage = null;
            var _loc16_: String = null;
            var _loc8_: String = null;
            var _loc6_: String = null;
            var _loc19_: RoomObjectAvatarSelectedMessage = null;
            var _loc3_: RoomObjectAvatarGuideStatusUpdateMessage = null;
            if (param1 == null || object == null) {
                return;
            }
            super.processUpdateMessage(param1);
            var _loc14_: IRoomObjectModelController = object.getModelController();
            if (param1 is RoomObjectAvatarPostureUpdateMessage) {
                _loc10_ = param1 as RoomObjectAvatarPostureUpdateMessage;
                _loc14_.setString("figure_posture", _loc10_.postureType);
                _loc14_.setString("figure_posture_parameter", _loc10_.parameter);
                return;
            }
            if (param1 is RoomObjectAvatarChatUpdateMessage) {
                _loc22_ = param1 as RoomObjectAvatarChatUpdateMessage;
                _loc14_.setNumber("figure_talk", 1);
                var_3405 = getTimer() + _loc22_.numberOfWords * 1000;
                return;
            }
            if (param1 is RoomObjectAvatarTypingUpdateMessage) {
                _loc26_ = param1 as RoomObjectAvatarTypingUpdateMessage;
                _loc14_.setNumber("figure_is_typing", Number(_loc26_.isTyping));
                return;
            }
            if (param1 is RoomObjectAvatarMutedUpdateMessage) {
                _loc11_ = param1 as RoomObjectAvatarMutedUpdateMessage;
                _loc14_.setNumber("figure_is_muted", Number(_loc11_.isMuted));
                return;
            }
            if (param1 is RoomObjectAvatarPlayingGameMessage) {
                _loc2_ = param1 as RoomObjectAvatarPlayingGameMessage;
                _loc14_.setNumber("figure_is_playing_game", Number(_loc2_.isPlayingGame));
                return;
            }
            if (param1 is RoomObjectAvatarUpdateMessage) {
                _loc18_ = param1 as RoomObjectAvatarUpdateMessage;
                _loc14_.setNumber("head_direction", _loc18_.dirHead);
                _loc14_.setNumber("figure_can_stand_up", Number(_loc18_.canStandUp));
                _loc14_.setNumber("figure_vertical_offset", _loc18_.baseY);
                return;
            }
            if (param1 is RoomObjectAvatarDirectionUpdateMessage) {
                _loc27_ = param1 as RoomObjectAvatarDirectionUpdateMessage;
                _loc14_.setNumber("head_direction", _loc27_.dirHead);
                return;
            }
            if (param1 is RoomObjectAvatarGestureUpdateMessage) {
                _loc17_ = param1 as RoomObjectAvatarGestureUpdateMessage;
                _loc14_.setNumber("figure_gesture", _loc17_.gesture);
                var_3479 = getTimer() + 3000;
                return;
            }
            if (param1 is RoomObjectAvatarExpressionUpdateMessage) {
                _loc14_.setNumber("figure_expression", RoomObjectAvatarExpressionUpdateMessage(param1).expressionType);
                var_2462 = class_3584.getExpressionTime(_loc14_.getNumber("figure_expression"));
                if (var_2462 > -1) {
                    var_2462 += getTimer();
                }
                return;
            }
            if (param1 is RoomObjectAvatarDanceUpdateMessage) {
                _loc12_ = param1 as RoomObjectAvatarDanceUpdateMessage;
                _loc14_.setNumber("figure_dance", _loc12_.danceStyle);
                return;
            }
            if (param1 is RoomObjectAvatarSleepUpdateMessage) {
                _loc13_ = param1 as RoomObjectAvatarSleepUpdateMessage;
                _loc14_.setNumber("figure_sleep", Number(_loc13_.isSleeping));
                return;
            }
            if (param1 is RoomObjectAvatarPlayerValueUpdateMessage) {
                _loc23_ = param1 as RoomObjectAvatarPlayerValueUpdateMessage;
                _loc14_.setNumber("figure_number_value", _loc23_.value);
                var_3520 = getTimer() + 3000;
                return;
            }
            if (param1 is RoomObjectAvatarEffectUpdateMessage) {
                _loc25_ = (_loc4_ = param1 as RoomObjectAvatarEffectUpdateMessage).effect;
                _loc9_ = _loc4_.delayMilliSeconds;
                updateEffect(_loc25_, _loc9_, _loc14_);
                return;
            }
            if (param1 is RoomObjectAvatarCarryObjectUpdateMessage) {
                _loc24_ = param1 as RoomObjectAvatarCarryObjectUpdateMessage;
                _loc14_.setNumber("figure_carry_object", _loc24_.itemType);
                _loc14_.setNumber("figure_use_object", 0);
                var_3072 = getTimer();
                if (_loc24_.itemType < 999999999) {
                    var_2892 = 0;
                    _allowUseCarryObject = _loc24_.itemType <= 999;
                } else {
                    var_2892 = var_3072 + 1500;
                    _allowUseCarryObject = false;
                }
                return;
            }
            if (param1 is RoomObjectAvatarUseObjectUpdateMessage) {
                _loc7_ = param1 as RoomObjectAvatarUseObjectUpdateMessage;
                _loc14_.setNumber("figure_use_object", _loc7_.itemType);
                return;
            }
            if (param1 is RoomObjectAvatarSignUpdateMessage) {
                _loc5_ = param1 as RoomObjectAvatarSignUpdateMessage;
                _loc14_.setNumber("figure_sign", _loc5_.signType);
                var_3400 = getTimer() + 5000;
                return;
            }
            if (param1 is RoomObjectAvatarFlatControlUpdateMessage) {
                _loc20_ = param1 as RoomObjectAvatarFlatControlUpdateMessage;
                _loc21_ = parseInt(_loc20_.rawData);
                if (_loc21_ == _loc21_ && _loc21_ >= 0 && _loc21_ <= 5) {
                    _loc14_.setNumber("figure_flat_control", _loc21_);
                } else {
                    _loc14_.setNumber("figure_flat_control", 0);
                }
                return;
            }
            if (param1 is RoomObjectAvatarFigureUpdateMessage) {
                _loc15_ = param1 as RoomObjectAvatarFigureUpdateMessage;
                _loc16_ = String(_loc14_.getString("figure"));
                _loc8_ = _loc15_.figure;
                _loc6_ = _loc15_.gender;
                if (_loc16_ != null && _loc16_.indexOf(".bds-") != -1) {
                    _loc8_ += _loc16_.substr(_loc16_.indexOf(".bds-"));
                }
                _loc14_.setString("figure", _loc8_);
                _loc14_.setString("gender", _loc6_);
                return;
            }
            if (param1 is RoomObjectAvatarSelectedMessage) {
                _selected = (_loc19_ = param1 as RoomObjectAvatarSelectedMessage).selected;
                var_2242 = null;
                return;
            }
            if (param1 is RoomObjectAvatarGuideStatusUpdateMessage) {
                _loc3_ = param1 as RoomObjectAvatarGuideStatusUpdateMessage;
                _loc14_.setNumber("figure_guide_status", _loc3_.guideStatus);
                return;
            }
            if (param1 is RoomObjectAvatarOwnMessage) {
                _loc14_.setNumber("own_user", 1);

            }
        }

        override public function mouseEvent(param1: RoomSpriteMouseEvent, param2: IRoomGeometry): void {
            var _loc5_: RoomObjectEvent = null;
            if (object == null || param1 == null) {
                return;
            }
            var _loc3_: IRoomObjectModelController = object.getModelController();
            var _loc4_: String = null;
            switch (param1.type) {
                case "click":
                    _loc4_ = "ROE_MOUSE_CLICK";
                    break;
                case "rollOver":
                    _loc4_ = "ROE_MOUSE_ENTER";
                    if (_loc3_ != null) {
                        _loc3_.setNumber("figure_highlight", 1);
                    }
                    eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent("ROFCAE_MOUSE_BUTTON", object));
                    break;
                case "rollOut":
                    if (_loc3_ != null) {
                        _loc3_.setNumber("figure_highlight", 0);
                    }
                    _loc4_ = "ROE_MOUSE_LEAVE";
                    eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent("ROFCAE_MOUSE_ARROW", object));
            }
            if (_loc4_ != null) {
                if (eventDispatcher != null) {
                    _loc5_ = new RoomObjectMouseEvent(_loc4_, object, param1.eventId, param1.altKey, param1.ctrlKey, param1.shiftKey, param1.buttonDown);
                    eventDispatcher.dispatchEvent(_loc5_);
                }
            }
        }

        override public function update(param1: int): void {
            var _loc2_: IVector3d = null;
            var _loc4_: RoomObjectEvent = null;
            var _loc3_: IRoomObjectModelController = null;
            super.update(param1);
            if (_selected && object != null) {
                if (eventDispatcher != null) {
                    _loc2_ = object.getLocation();
                    if (var_2242 == null || var_2242.x != _loc2_.x || var_2242.y != _loc2_.y || var_2242.z != _loc2_.z) {
                        if (var_2242 == null) {
                            var_2242 = new Vector3d();
                        }
                        var_2242.assign(_loc2_);
                        _loc4_ = new RoomObjectMoveEvent("ROME_POSITION_CHANGED", object);
                        eventDispatcher.dispatchEvent(_loc4_);
                    }
                }
            }
            if (object != null) {
                _loc3_ = object.getModelController();
                if (_loc3_ != null) {
                    updateActions(param1, _loc3_);
                }
            }
        }

        private function updateEffect(param1: int, param2: int, param3: IRoomObjectModelController): void {
            if (param1 == 28) {
                var_1960 = getTimer() + 500;
                var_2299 = 29;
            } else if (param1 == 184) {
                var_1960 = getTimer() + 500;
                var_2299 = 185;
            } else if (param3.getNumber("figure_effect") == 29) {
                var_1960 = getTimer() + 500;
                var_2299 = param1;
                param1 = 28;
            } else if (param3.getNumber("figure_effect") == 185) {
                var_1960 = getTimer() + 500;
                var_2299 = param1;
                param1 = 184;
            } else {
                if (param2 != 0) {
                    var_1960 = getTimer() + param2;
                    var_2299 = param1;
                    return;
                }
                var_1960 = 0;
            }
            param3.setNumber("figure_effect", param1);
        }

        private function updateActions(param1: int, param2: IRoomObjectModelController): void {
            if (var_3405 > 0) {
                if (param1 > var_3405) {
                    param2.setNumber("figure_talk", 0);
                    var_3405 = 0;
                    var_2515 = 0;
                    var_2644 = 0;
                } else if (var_2644 == 0 && var_2515 == 0) {
                    var_2515 = param1 + getTalkingPauseInterval();
                    var_2644 = var_2515 + getTalkingPauseLength();
                } else if (var_2515 > 0 && param1 > var_2515) {
                    param2.setNumber("figure_talk", 0);
                    var_2515 = 0;
                } else if (var_2644 > 0 && param1 > var_2644) {
                    param2.setNumber("figure_talk", 1);
                    var_2644 = 0;
                }
            }
            if (var_2462 > 0 && param1 > var_2462) {
                param2.setNumber("figure_expression", 0);
                var_2462 = 0;
            }
            if (var_3479 > 0 && param1 > var_3479) {
                param2.setNumber("figure_gesture", 0);
                var_3479 = 0;
            }
            if (var_3400 > 0 && param1 > var_3400) {
                param2.setNumber("figure_sign", -1);
                var_3400 = 0;
            }
            if (var_2892 > 0) {
                if (param1 > var_2892) {
                    param2.setNumber("figure_carry_object", 0);
                    param2.setNumber("figure_use_object", 0);
                    var_3072 = var_2892 = 0;
                    _allowUseCarryObject = false;
                }
            }
            if (_allowUseCarryObject) {
                if (param1 - var_3072 > 5000) {
                    if ((param1 - var_3072) % 10000 < 1000) {
                        param2.setNumber("figure_use_object", 1);
                    } else {
                        param2.setNumber("figure_use_object", 0);
                    }
                }
            }
            if (param1 > var_3828) {
                param2.setNumber("figure_blink", 1);
                var_3828 = param1 + getBlinkInterval();
                var_3486 = param1 + getBlinkLength();
            }
            if (var_3486 > 0 && param1 > var_3486) {
                param2.setNumber("figure_blink", 0);
                var_3486 = 0;
            }
            if (var_1960 > 0 && param1 > var_1960) {
                param2.setNumber("figure_effect", var_2299);
                var_1960 = 0;
            }
            if (var_3520 > 0 && param1 > var_3520) {
                param2.setNumber("figure_number_value", 0);
                var_3520 = 0;
            }
        }

        private function getTalkingPauseInterval(): int {
            return 100 + Math.random() * 200;
        }

        private function getTalkingPauseLength(): int {
            return 75 + Math.random() * 75;
        }

        private function getBlinkInterval(): int {
            return 4500 + Math.random() * 1000;
        }

        private function getBlinkLength(): int {
            return 50 + Math.random() * 200;
        }

        private function targetIsWarping(param1: IVector3d): Boolean {
            var _loc2_: IVector3d = object.getLocation();
            if (param1 == null) {
                return false;
            }
            if (_loc2_.x == 0 && _loc2_.y == 0) {
                return false;
            }
            if (Math.abs(_loc2_.x - param1.x) > 1.5 || Math.abs(_loc2_.y - param1.y) > 1.5) {
                return true;
            }
            return false;
        }
    }
}
