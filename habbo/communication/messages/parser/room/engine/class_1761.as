package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.room.utils.Vector3d

    [SecureSWF(rename="true")]
    public class class_1761 {

        public function class_1761(param1: int, param2: Vector3d, param3: Vector3d, param4: String, param5: Number, param6: Number, param7: Number) {
            super();
            var_771 = param1;
            var_1099 = param2;
            var_294 = param3;
            var_595 = param4;
            _animationTime = param5;
            var_822 = param6;
            _headDirection = param7;
        }
        private var var_771: int;
        private var var_1099: Vector3d;
        private var var_294: Vector3d;
        private var var_595: String;
        private var var_822: Number;

        private var _animationTime: Number;

        public function get animationTime(): Number {
            return _animationTime;
        }

        private var _headDirection: Number;

        public function get headDirection(): Number {
            return _headDirection;
        }

        public function get userIndex(): int {
            return var_771;
        }

        public function get source(): Vector3d {
            return var_1099;
        }

        public function get target(): Vector3d {
            return var_294;
        }

        public function get moveType(): String {
            return var_595;
        }

        public function get bodyDirection(): Number {
            return var_822;
        }
    }
}
