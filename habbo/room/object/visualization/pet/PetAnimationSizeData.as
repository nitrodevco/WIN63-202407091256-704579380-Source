package com.sulake.habbo.room.object.visualization.pet {
    import com.sulake.core.utils.Map
    import com.sulake.habbo.room.object.visualization.data.*
    import com.sulake.room.utils.class_1781

    public class PetAnimationSizeData extends AnimationSizeData {

        public static const const_512: int = -1;

        public function PetAnimationSizeData(param1: int, param2: int) {
            var_2715 = new Map();
            var_2484 = new Map();
            super(param1, param2);
        }
        private var var_2715: Map;
        private var var_2484: Map;
        private var _defaultPosture: String;

        public function definePostures(param1: XML): Boolean {
            var _loc5_: int = 0;
            var _loc2_: XML = null;
            var _loc6_: String = null;
            var _loc7_: int = 0;
            if (param1 == null) {
                return false;
            }
            if (class_1781.checkRequiredAttributes(param1, ["defaultPosture"])) {
                _defaultPosture = param1.@defaultPosture;
            } else {
                _defaultPosture = null;
            }
            var _loc3_: Array = ["id", "animationId"];
            var _loc4_: XMLList = param1.posture;
            _loc5_ = 0;
            while (_loc5_ < _loc4_.length()) {
                _loc2_ = _loc4_[_loc5_];
                if (!class_1781.checkRequiredAttributes(_loc2_, _loc3_)) {
                    return false;
                }
                _loc6_ = String(_loc2_.@id);
                _loc7_ = int(_loc2_.@animationId);
                var_2715.add(_loc6_, _loc7_);
                if (_defaultPosture == null) {
                    _defaultPosture = _loc6_;
                }
                _loc5_++;
            }
            if (var_2715.getValue(_defaultPosture) == null) {
                return false;
            }
            return true;
        }

        public function defineGestures(param1: XML): Boolean {
            var _loc2_: int = 0;
            var _loc7_: XML = null;
            var _loc3_: String = null;
            var _loc5_: int = 0;
            if (param1 == null) {
                return true;
            }
            var _loc4_: Array = ["id", "animationId"];
            var _loc6_: XMLList = param1.gesture;
            _loc2_ = 0;
            while (_loc2_ < _loc6_.length()) {
                _loc7_ = _loc6_[_loc2_];
                if (!class_1781.checkRequiredAttributes(_loc7_, _loc4_)) {
                    return false;
                }
                _loc3_ = String(_loc7_.@id);
                _loc5_ = int(_loc7_.@animationId);
                var_2484.add(_loc3_, _loc5_);
                _loc2_++;
            }
            return true;
        }

        public function getAnimationForPosture(param1: String): int {
            if (var_2715.getValue(param1) == null) {
                param1 = _defaultPosture;
            }
            return var_2715.getValue(param1);
        }

        public function getGestureDisabled(param1: String): Boolean {
            if (param1 == "ded") {
                return true;
            }
            return false;
        }

        public function getAnimationForGesture(param1: String): int {
            if (var_2484.getValue(param1) == null) {
                return -1;
            }
            return var_2484.getValue(param1);
        }

        public function getPostureForAnimation(param1: int, param2: Boolean): String {
            if (param1 >= 0 && param1 < var_2715.length) {
                return var_2715.getKey(param1);
            }
            return param2 ? _defaultPosture : null;
        }

        public function getGestureForAnimation(param1: int): String {
            if (param1 >= 0 && param1 < var_2484.length) {
                return var_2484.getKey(param1);
            }
            return null;
        }

        public function getGestureForAnimationId(param1: int): String {
            for each(var _loc2_ in var_2484.getKeys()) {
                if (var_2484.getValue(_loc2_) == param1) {
                    return _loc2_;
                }
            }
            return null;
        }

        public function getPostureCount(): int {
            return var_2715.length;
        }

        public function getGestureCount(): int {
            return var_2484.length;
        }
    }
}
