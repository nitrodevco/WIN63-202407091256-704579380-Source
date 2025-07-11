package com.sulake.habbo.room.object.visualization.data {
    public class AnimationStateData {

        public function AnimationStateData() {
            var_1862 = [];
            var_2734 = [];
            var_2588 = [];
            super();
        }
        private var var_4173: int = -1;
        private var var_4670: int = 0;
        private var var_3070: Boolean = false;
        private var var_2172: int = 0;
        private var var_1862: Array;
        private var var_2734: Array;
        private var var_2588: Array;
        private var var_2448: int = 0;

        public function get animationOver(): Boolean {
            return var_3070;
        }

        public function set animationOver(param1: Boolean): void {
            var_3070 = param1;
        }

        public function get frameCounter(): int {
            return var_2172;
        }

        public function set frameCounter(param1: int): void {
            var_2172 = param1;
        }

        public function get animationId(): int {
            return var_4173;
        }

        public function set animationId(param1: int): void {
            if (param1 != var_4173) {
                var_4173 = param1;
                resetAnimationFrames(false);
            }
        }

        public function get animationAfterTransitionId(): int {
            return var_4670;
        }

        public function set animationAfterTransitionId(param1: int): void {
            var_4670 = param1;
        }

        public function dispose(): void {
            recycleFrames();
            var_1862 = null;
            var_2734 = null;
            var_2588 = null;
        }

        public function setLayerCount(param1: int): void {
            var_2448 = param1;
            resetAnimationFrames();
        }

        public function resetAnimationFrames(param1: Boolean = true): void {
            var _loc2_: int = 0;
            var _loc3_: AnimationFrame = null;
            if (param1 || var_1862 == null) {
                recycleFrames();
                var_1862 = [];
            }
            var_2734 = [];
            var_2588 = [];
            var_3070 = false;
            var_2172 = 0;
            _loc2_ = 0;
            while (_loc2_ < var_2448) {
                if (param1 || var_1862.length <= _loc2_) {
                    var_1862[_loc2_] = null;
                } else {
                    _loc3_ = var_1862[_loc2_];
                    if (_loc3_ != null) {
                        _loc3_.recycle();
                        var_1862[_loc2_] = AnimationFrame.allocate(_loc3_.id, _loc3_.x, _loc3_.y, _loc3_.repeats, 0, _loc3_.isLastFrame);
                    }
                }
                var_2734[_loc2_] = false;
                var_2588[_loc2_] = false;
                _loc2_++;
            }
        }

        public function getFrame(param1: int): AnimationFrame {
            if (param1 >= 0 && param1 < var_2448) {
                return var_1862[param1];
            }
            return null;
        }

        public function setFrame(param1: int, param2: AnimationFrame): void {
            var _loc3_: AnimationFrame = null;
            if (param1 >= 0 && param1 < var_2448) {
                _loc3_ = var_1862[param1];
                if (_loc3_ != null) {
                    _loc3_.recycle();
                }
                var_1862[param1] = param2;
            }
        }

        public function getAnimationPlayed(param1: int): Boolean {
            if (param1 >= 0 && param1 < var_2448) {
                return var_2588[param1];
            }
            return true;
        }

        public function setAnimationPlayed(param1: int, param2: Boolean): void {
            if (param1 >= 0 && param1 < var_2448) {
                var_2588[param1] = param2;
            }
        }

        public function getLastFramePlayed(param1: int): Boolean {
            if (param1 >= 0 && param1 < var_2448) {
                return var_2734[param1];
            }
            return true;
        }

        public function setLastFramePlayed(param1: int, param2: Boolean): void {
            if (param1 >= 0 && param1 < var_2448) {
                var_2734[param1] = param2;
            }
        }

        private function recycleFrames(): void {
            if (var_1862 != null) {
                for each(var _loc1_ in var_1862) {
                    if (_loc1_ != null) {
                        _loc1_.recycle();
                    }
                }
            }
        }
    }
}
