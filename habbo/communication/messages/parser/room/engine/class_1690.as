package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.room.utils.Vector3d

    [SecureSWF(rename="true")]
    public class class_1690 {

        public function class_1690(param1: int, param2: Vector3d, param3: Vector3d, param4: Number, param5: Number) {
            super();
            var_603 = param1;
            var_1099 = param2;
            var_294 = param3;
            _animationTime = param4;
            var_1239 = param5;
        }
        private var var_603: int;
        private var var_1099: Vector3d;
        private var var_294: Vector3d;
        private var var_1239: Number;

        private var _animationTime: Number;

        public function get animationTime(): Number {
            return _animationTime;
        }

        public function get furniId(): int {
            return var_603;
        }

        public function get source(): Vector3d {
            return var_1099;
        }

        public function get target(): Vector3d {
            return var_294;
        }

        public function get rotation(): Number {
            return var_1239;
        }
    }
}
