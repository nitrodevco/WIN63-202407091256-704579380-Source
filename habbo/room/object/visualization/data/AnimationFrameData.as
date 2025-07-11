package com.sulake.habbo.room.object.visualization.data {
    public class AnimationFrameData {

        public function AnimationFrameData(param1: int, param2: int, param3: int, param4: int, param5: int, param6: int) {
            super();
            var_280 = param1;
            var_31 = param2;
            var_28 = param3;
            var_4272 = param4;
            var_4463 = param5;
            var_4546 = param6;
        }
        private var var_280: int = 0;
        private var var_31: int = 0;
        private var var_28: int = 0;
        private var var_4272: int = 0;
        private var var_4463: int = 0;
        private var var_4546: int = 1;

        public function get id(): int {
            return var_280;
        }

        public function get x(): int {
            return var_31;
        }

        public function get y(): int {
            return var_31;
        }

        public function get randomX(): int {
            return var_4272;
        }

        public function get randomY(): int {
            return var_4463;
        }

        public function get repeats(): int {
            return var_4546;
        }

        public function hasDirectionalOffsets(): Boolean {
            return false;
        }

        public function getX(param1: int): int {
            return var_31;
        }

        public function getY(param1: int): int {
            return var_28;
        }
    }
}
