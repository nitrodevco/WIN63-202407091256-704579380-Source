package com.sulake.habbo.room.object.visualization.furniture {
    public class FurnitureHabboWheelVisualization extends AnimatedFurnitureVisualization {

        private static const ANIMATION_ID_OFFSET_SLOW1: int = 10;

        private static const ANIMATION_ID_OFFSET_SLOW2: int = 20;

        private static const const_572: int = 31;

        private static const const_498: int = 32;

        public function FurnitureHabboWheelVisualization() {
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
                    var_1971.push(31);
                    var_1971.push(32);
                    return;
                }
            }
            if (param1 > 0 && param1 <= 10) {
                if (var_92) {
                    var_92 = false;
                    var_1971 = [];
                    var_1971.push(10 + param1);
                    var_1971.push(20 + param1);
                    var_1971.push(param1);
                    return;
                }
                super.setAnimation(param1);
            }
        }

        override protected function updateAnimation(param1: Number): int {
            if (super.getLastFramePlayed(1) && super.getLastFramePlayed(2) && super.getLastFramePlayed(3)) {
                if (var_1971.length > 0) {
                    super.setAnimation(var_1971.shift());
                }
            }
            return super.updateAnimation(param1);
        }
    }
}
