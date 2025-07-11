package com.sulake.habbo.room.object.visualization.furniture {
    public class FurnitureQueueTileVisualization extends AnimatedFurnitureVisualization {

        private static const const_498: int = 3;

        private static const const_1184: int = 2;

        private static const ANIMATION_ID_NORMAL: int = 1;

        private static const const_1192: int = 15;

        public function FurnitureQueueTileVisualization() {
            var_1971 = [];
            super();
        }
        private var var_1971: Array;
        private var var_2166: int;

        override protected function setAnimation(param1: int): void {
            if (param1 == 2) {
                var_1971 = [];
                var_1971.push(1);
                var_2166 = 15;
            }
            super.setAnimation(param1);
        }

        override protected function updateAnimation(param1: Number): int {
            if (var_2166 > 0) {
                var_2166--;
            }
            if (var_2166 == 0) {
                if (var_1971.length > 0) {
                    super.setAnimation(var_1971.shift());
                }
            }
            return super.updateAnimation(param1);
        }

        override protected function usesAnimationResetting(): Boolean {
            return true;
        }
    }
}
