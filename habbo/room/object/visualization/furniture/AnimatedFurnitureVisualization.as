package com.sulake.habbo.room.object.visualization.furniture {
    import com.sulake.habbo.room.object.visualization.data.AnimationData
    import com.sulake.habbo.room.object.visualization.data.AnimationFrame
    import com.sulake.habbo.room.object.visualization.data.AnimationStateData
    import com.sulake.room.object.IRoomObject
    import com.sulake.room.object.IRoomObjectModel
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData

    public class AnimatedFurnitureVisualization extends FurnitureVisualization {

        public static const DEFAULT_ANIMATION_ID: int = 0;

        public function AnimatedFurnitureVisualization() {
            super();
            var_1784 = new AnimationStateData();
        }
        protected var var_2871: Boolean = false;
        private var var_1793: AnimatedFurnitureVisualizationData = null;
        private var var_149: int = -1;
        private var var_1784: AnimationStateData;
        private var _animationChangeTime: int = 0;
        private var var_4038: int = 1;
        private var var_2344: Number = 0;
        private var var_3448: int = 0;

        public function get animationId(): int {
            return var_1784.animationId;
        }

        protected function get animatedLayerCount(): int {
            return var_3448;
        }

        protected function get frameIncrease(): int {
            return var_4038;
        }

        override public function dispose(): void {
            super.dispose();
            var_1793 = null;
            if (var_1784 != null) {
                var_1784.dispose();
                var_1784 = null;
            }
        }

        override public function initialize(param1: IRoomObjectVisualizationData): Boolean {
            if (!(param1 is AnimatedFurnitureVisualizationData)) {
                return false;
            }
            var_1793 = param1 as AnimatedFurnitureVisualizationData;
            return super.initialize(param1);
        }

        override protected function updateObject(param1: Number, param2: Number): Boolean {
            var _loc3_: IRoomObject = null;
            var _loc6_: int = 0;
            var _loc4_: IRoomObjectModel = null;
            var _loc5_: int = 0;
            if (super.updateObject(param1, param2)) {
                _loc3_ = object;
                if (_loc3_ == null) {
                    return false;
                }
                if ((_loc6_ = _loc3_.getState(0)) != var_149) {
                    setAnimation(_loc6_);
                    var_149 = _loc6_;
                    if ((_loc4_ = _loc3_.getModel()) != null) {
                        _animationChangeTime = _loc5_ = int(_loc4_.getNumber("furniture_state_update_time"));
                    }
                }
                return true;
            }
            return false;
        }

        override protected function updateModel(param1: Number): Boolean {
            var _loc2_: IRoomObject = null;
            var _loc4_: IRoomObjectModel = null;
            var _loc5_: int = 0;
            var _loc3_: Number = NaN;
            var _loc6_: int = 0;
            if (super.updateModel(param1)) {
                _loc2_ = object;
                if (_loc2_ != null) {
                    if ((_loc4_ = _loc2_.getModel()) != null) {
                        if (usesAnimationResetting()) {
                            if ((_loc5_ = int(_loc4_.getNumber("furniture_state_update_time"))) > _animationChangeTime) {
                                _animationChangeTime = _loc5_;
                                setAnimation(var_149);
                            }
                        }
                        _loc3_ = Number(_loc4_.getNumber("furniture_automatic_state_index"));
                        if (!isNaN(_loc3_)) {
                            _loc6_ = var_1793.getAnimationId(var_2344, _loc3_);
                            setAnimation(_loc6_);
                        }
                    }
                }
                return true;
            }
            return false;
        }

        override protected function updateAnimation(param1: Number): int {
            if (var_1793 == null) {
                return 0;
            }
            if (param1 != var_2344) {
                var_2344 = param1;
                var_3448 = var_1793.getLayerCount(param1);
                resetAllAnimationFrames();
            }
            var _loc2_: int = updateAnimations(param1);
            var_2871 = false;
            return _loc2_;
        }

        override protected function getFrameNumber(param1: int, param2: int): int {
            var _loc3_: AnimationFrame = var_1784.getFrame(param2);
            if (_loc3_ != null) {
                return _loc3_.id;
            }
            return super.getFrameNumber(param1, param2);
        }

        override protected function getSpriteXOffset(param1: int, param2: int, param3: int): int {
            var _loc4_: int = super.getSpriteXOffset(param1, param2, param3);
            var _loc5_: AnimationFrame;
            if ((_loc5_ = var_1784.getFrame(param3)) != null) {
                _loc4_ += _loc5_.x;
            }
            return _loc4_;
        }

        override protected function getSpriteYOffset(param1: int, param2: int, param3: int): int {
            var _loc4_: int = super.getSpriteYOffset(param1, param2, param3);
            var _loc5_: AnimationFrame;
            if ((_loc5_ = var_1784.getFrame(param3)) != null) {
                _loc4_ += _loc5_.y;
            }
            return _loc4_;
        }

        protected function getAnimationId(param1: AnimationStateData): int {
            var _loc2_: int = animationId;
            if (_loc2_ != 0 && var_1793.hasAnimation(var_2344, _loc2_)) {
                return _loc2_;
            }
            return 0;
        }

        protected function setAnimation(param1: int): void {
            if (var_1793 != null) {
                setSubAnimation(var_1784, param1, var_149 >= 0);
            }
        }

        protected function setSubAnimation(param1: AnimationStateData, param2: int, param3: Boolean = true): Boolean {
            var _loc5_: int = 0;
            var _loc6_: int = 0;
            var _loc4_: int = param1.animationId;
            if (param3) {
                if (isPlayingTransition(param1, param2)) {
                    return false;
                }
                _loc5_ = getCurrentState(param1);
                if (param2 != _loc5_) {
                    if (!var_1793.isImmediateChange(var_2344, param2, _loc5_)) {
                        _loc6_ = AnimationData.getTransitionFromAnimationId(_loc5_);
                        if (var_1793.hasAnimation(var_2344, _loc6_)) {
                            param1.animationAfterTransitionId = param2;
                            param2 = _loc6_;
                        } else {
                            _loc6_ = AnimationData.getTransitionToAnimationId(param2);
                            if (var_1793.hasAnimation(var_2344, _loc6_)) {
                                param1.animationAfterTransitionId = param2;
                                param2 = _loc6_;
                            }
                        }
                    }
                } else if (AnimationData.isTransitionFromAnimation(_loc4_)) {
                    _loc6_ = AnimationData.getTransitionToAnimationId(param2);
                    if (var_1793.hasAnimation(var_2344, _loc6_)) {
                        param1.animationAfterTransitionId = param2;
                        param2 = _loc6_;
                    }
                } else if (!AnimationData.isTransitionToAnimation(_loc4_)) {
                    if (usesAnimationResetting()) {
                        _loc6_ = AnimationData.getTransitionFromAnimationId(_loc5_);
                        if (var_1793.hasAnimation(var_2344, _loc6_)) {
                            param1.animationAfterTransitionId = param2;
                            param2 = _loc6_;
                        } else {
                            _loc6_ = AnimationData.getTransitionToAnimationId(param2);
                            if (var_1793.hasAnimation(var_2344, _loc6_)) {
                                param1.animationAfterTransitionId = param2;
                                param2 = _loc6_;
                            }
                        }
                    }
                }
            }
            if (_loc4_ != param2) {
                param1.animationId = param2;
                return true;
            }
            return false;
        }

        protected function getLastFramePlayed(param1: int): Boolean {
            return var_1784.getLastFramePlayed(param1);
        }

        protected function resetAllAnimationFrames(): void {
            if (var_1784 != null) {
                var_1784.setLayerCount(var_3448);
            }
        }

        protected function updateAnimations(param1: Number): int {
            var _loc2_: int = 0;
            if (!var_1784.animationOver || var_2871) {
                _loc2_ = updateFramesForAnimation(var_1784, param1);
                if (var_1784.animationOver) {
                    if (AnimationData.isTransitionFromAnimation(var_1784.animationId) || AnimationData.isTransitionToAnimation(var_1784.animationId)) {
                        setAnimation(var_1784.animationAfterTransitionId);
                        var_1784.animationOver = false;
                    }
                }
            }
            return _loc2_;
        }

        protected function updateFramesForAnimation(param1: AnimationStateData, param2: Number): int {
            var _loc7_: int = 0;
            var _loc5_: Boolean = false;
            var _loc6_: Boolean = false;
            var _loc11_: AnimationFrame = null;
            var _loc3_: int = 0;
            if (param1.animationOver && !var_2871) {
                return 0;
            }
            var _loc4_: int = param1.frameCounter;
            var _loc8_: int = getAnimationId(param1);
            if (_loc4_ == 0) {
                _loc4_ = var_1793.getStartFrame(param2, _loc8_, direction);
            }
            _loc4_ += frameIncrease;
            param1.frameCounter = _loc4_;
            var _loc9_: * = 0;
            param1.animationOver = true;
            var _loc10_: * = 1 << var_3448 - 1;
            _loc7_ = var_3448 - 1;
            while (_loc7_ >= 0) {
                if (!(_loc5_ = param1.getAnimationPlayed(_loc7_)) || var_2871) {
                    _loc6_ = param1.getLastFramePlayed(_loc7_);
                    if ((_loc11_ = param1.getFrame(_loc7_)) != null) {
                        if (_loc11_.isLastFrame && _loc11_.remainingFrameRepeats <= frameIncrease) {
                            _loc6_ = true;
                        }
                    }
                    if (var_2871 || _loc11_ == null || _loc11_.remainingFrameRepeats >= 0 && (_loc11_.remainingFrameRepeats -= frameIncrease) <= 0) {
                        _loc3_ = -1;
                        if (_loc11_ != null) {
                            _loc3_ = _loc11_.activeSequence;
                        }
                        if (_loc3_ == -1) {
                            _loc11_ = var_1793.getFrame(param2, _loc8_, direction, _loc7_, _loc4_);
                        } else {
                            _loc11_ = var_1793.getFrameFromSequence(param2, _loc8_, direction, _loc7_, _loc3_, _loc11_.activeSequenceOffset + _loc11_.repeats, _loc4_);
                        }
                        param1.setFrame(_loc7_, _loc11_);
                        _loc9_ |= _loc10_;
                    }
                    if (_loc11_ == null || _loc11_.remainingFrameRepeats == -1) {
                        _loc6_ = true;
                        _loc5_ = true;
                    } else {
                        param1.animationOver = false;
                    }
                    param1.setLastFramePlayed(_loc7_, _loc6_);
                    param1.setAnimationPlayed(_loc7_, _loc5_);
                }
                _loc10_ >>= 1;
                _loc7_--;
            }
            return _loc9_;
        }

        protected function usesAnimationResetting(): Boolean {
            return false;
        }

        private function isPlayingTransition(param1: AnimationStateData, param2: int): Boolean {
            var _loc3_: int = param1.animationId;
            if (AnimationData.isTransitionFromAnimation(_loc3_) || AnimationData.isTransitionToAnimation(_loc3_)) {
                if (param2 == param1.animationAfterTransitionId) {
                    if (!param1.animationOver) {
                        return true;
                    }
                }
            }
            return false;
        }

        private function getCurrentState(param1: AnimationStateData): int {
            var _loc2_: int = param1.animationId;
            if (AnimationData.isTransitionFromAnimation(_loc2_) || AnimationData.isTransitionToAnimation(_loc2_)) {
                return param1.animationAfterTransitionId;
            }
            return _loc2_;
        }
    }
}
