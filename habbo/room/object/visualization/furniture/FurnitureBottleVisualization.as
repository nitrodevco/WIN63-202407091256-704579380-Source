package com.sulake.habbo.room.object.visualization.furniture {
    public class FurnitureBottleVisualization extends AnimatedFurnitureVisualization {

        private static const ANIMATION_ID_OFFSET_SLOW1: int = 20;

        private static const ANIMATION_ID_OFFSET_SLOW2: int = 9;

        private static const const_498: int = -1;

        public function FurnitureBottleVisualization() {
            var_1971 = [];
            super();
        }
        private var var_1971: Array;
        private var var_92: Boolean = false;

        override protected function setAnimation(param1: int): void {
            if (param1 == -1) {
                if (!var_92) {
                    var_92 = true;
                    var_1971 = [];
                    var_1971.push(-1);
                    return;
                }
            }
            if (param1 >= 0 && param1 <= 7) {
                if (var_92) {
                    var_92 = false;
                    var_1971 = [];
                    var_1971.push(20);
                    var_1971.push(9 + param1);
                    var_1971.push(param1);
                    return;
                }
                super.setAnimation(param1);
            }
        }

        override protected function updateAnimation(param1: Number): int {
            if (super.getLastFramePlayed(0)) {
                if (var_1971.length > 0) {
                    super.setAnimation(var_1971.shift());
                }
            }
            return super.updateAnimation(param1);
        }
    }
}
