package com.sulake.habbo.room.object.visualization.furniture {
    public class class_3379 extends AnimatedFurnitureVisualization {

        public function class_3379() {
            super();
        }
        private var var_4038: int = 1;
        private var var_3158: Number = 0;

        override protected function get frameIncrease(): int {
            return var_4038;
        }

        override protected function updateAnimations(param1: Number): int {
            var_3158 += object.getModel().getNumber("furniture_soundblock_relative_animation_speed");
            var_4038 = var_3158;
            var_3158 -= var_4038;
            return super.updateAnimations(param1);
        }
    }
}
