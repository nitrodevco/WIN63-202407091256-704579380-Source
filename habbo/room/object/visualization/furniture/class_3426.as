package com.sulake.habbo.room.object.visualization.furniture {
    import com.sulake.room.object.IRoomObjectModel

    public class class_3426 extends AnimatedFurnitureVisualization {

        private static const ONES_SPRITE_TAG: String = "ones_sprite";

        private static const TENS_SPRITE_TAG: String = "tens_sprite";

        private static const HUNDREDS_SPRITE_TAG: String = "hundreds_sprite";

        private static const HIDE_RESULTS_STATES: Array = [-1, 1];

        private static const const_609: int = -1;

        public function class_3426() {
            super();
        }

        override protected function updateObject(param1: Number, param2: Number): Boolean {
            super.updateObject(param1, param2);
            return true;
        }

        override protected function getFrameNumber(param1: int, param2: int): int {
            var _loc4_: IRoomObjectModel;
            var _loc5_: int = int((_loc4_ = object.getModel()).getNumber("furniture_vote_majority_result"));
            var _loc3_: String = getSpriteTag(param1, direction, param2);
            switch (_loc3_) {
                case "ones_sprite":
                    return _loc5_ % 10;
                case "tens_sprite":
                    return _loc5_ / 10 % 10;
                case "hundreds_sprite":
                    return _loc5_ / 100 % 10;
                default:
                    return super.getFrameNumber(param1, param2);
            }
        }

        override protected function getSpriteAlpha(param1: int, param2: int, param3: int): int {
            var _loc4_: String = null;
            var _loc5_: IRoomObjectModel;
            var _loc6_: int = int((_loc5_ = object.getModel()).getNumber("furniture_vote_majority_result"));
            if (HIDE_RESULTS_STATES.indexOf(object.getState(0)) != -1 || _loc6_ == -1) {
                switch (_loc4_ = getSpriteTag(param1, param2, param3)) {
                    case "ones_sprite":
                    case "tens_sprite":
                    case "hundreds_sprite":
                }
                return 0;
            }
            return super.getSpriteAlpha(param1, param2, param3);
        }
    }
}
