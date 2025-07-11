package com.sulake.habbo.room.object.visualization.data {
    public class AnimationFrame {

        public static const FRAME_REPEAT_FOREVER: int = -1;

        public static const const_607: int = -1;

        private static const POOL_SIZE_LIMIT: int = 3000;

        private static const const_422: Array = [];

        public static function allocate(param1: int, param2: int, param3: int, param4: int, param5: int, param6: Boolean, param7: int = -1, param8: int = 0): AnimationFrame {
            var _loc9_: AnimationFrame;
            (_loc9_ = const_422.length > 0 ? const_422.pop() : new AnimationFrame()).var_4125 = false;
            _loc9_.var_280 = param1;
            _loc9_.var_31 = param2;
            _loc9_.var_28 = param3;
            _loc9_._isLastFrame = param6;
            if (param4 < 1) {
                param4 = 1;
            }
            _loc9_.var_4546 = param4;
            if (param5 < 0) {
                param5 = -1;
            }
            _loc9_.var_3503 = param5;
            _loc9_.var_4188 = param5;
            if (param7 >= 0) {
                _loc9_.var_4872 = param7;
                _loc9_._activeSequenceOffset = param8;
            }
            return _loc9_;
        }

        public function AnimationFrame() {
            super();
        }
        private var var_280: int = 0;
        private var var_31: int = 0;
        private var var_28: int = 0;
        private var var_4546: int = 1;
        private var var_3503: int = 1;
        private var var_4188: int = 1;
        private var var_4872: int = -1;
        private var var_4125: Boolean = false;

        private var _activeSequenceOffset: int = 0;

        public function get activeSequenceOffset(): int {
            return _activeSequenceOffset;
        }

        private var _isLastFrame: Boolean = false;

        public function get isLastFrame(): Boolean {
            return _isLastFrame;
        }

        public function get id(): int {
            if (var_280 >= 0) {
                return var_280;
            }
            return -var_280 * Math.random();
        }

        public function get x(): int {
            return var_31;
        }

        public function get y(): int {
            return var_28;
        }

        public function get repeats(): int {
            return var_4546;
        }

        public function get frameRepeats(): int {
            return var_3503;
        }

        public function get remainingFrameRepeats(): int {
            if (var_3503 < 0) {
                return -1;
            }
            return var_4188;
        }

        public function set remainingFrameRepeats(param1: int): void {
            if (param1 < 0) {
                param1 = 0;
            }
            if (var_3503 > 0 && param1 > var_3503) {
                param1 = var_3503;
            }
            var_4188 = param1;
        }

        public function get activeSequence(): int {
            return var_4872;
        }

        public function recycle(): void {
            if (!var_4125) {
                var_4125 = true;
                if (const_422.length < 3000) {
                    const_422.push(this);
                }
            }
        }
    }
}
