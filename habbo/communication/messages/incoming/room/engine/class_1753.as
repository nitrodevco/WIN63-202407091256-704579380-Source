package com.sulake.habbo.communication.messages.incoming.room.engine {
    [SecureSWF(rename="true")]
    public class class_1753 {

        public function class_1753(param1: int, param2: Number, param3: Number, param4: Number, param5: Number, param6: int, param7: int, param8: Number, param9: Number, param10: Number, param11: Boolean, param12: Boolean, param13: Array, param14: Boolean) {
            var_531 = [];
            super();
            var_280 = param1;
            var_31 = param2;
            var_28 = param3;
            var_30 = param4;
            var_961 = param5;
            var_643 = param6;
            var_1146 = param7;
            var_932 = param8;
            var_1081 = param9;
            var_1274 = param10;
            var_1257 = param11;
            var_1168 = param12;
            var_531 = param13;
            _skipPositionUpdate = param14;
        }
        private var var_280: int = 0;
        private var var_31: Number = 0;
        private var var_28: Number = 0;
        private var var_30: Number = 0;
        private var var_961: Number = 0;
        private var var_932: Number = 0;
        private var var_1081: Number = 0;
        private var var_1274: Number = 0;
        private var var_643: int = 0;
        private var var_1146: int = 0;
        private var var_531: Array;
        private var var_1257: Boolean = false;
        private var var_1168: Boolean = false;

        private var _skipPositionUpdate: Boolean = false;

        public function get skipPositionUpdate(): Boolean {
            return _skipPositionUpdate;
        }

        public function get id(): int {
            return var_280;
        }

        public function get x(): Number {
            return var_31;
        }

        public function get y(): Number {
            return var_28;
        }

        public function get z(): Number {
            return var_30;
        }

        public function get localZ(): Number {
            return var_961;
        }

        public function get targetX(): Number {
            return var_932;
        }

        public function get targetY(): Number {
            return var_1081;
        }

        public function get targetZ(): Number {
            return var_1274;
        }

        public function get dir(): int {
            return var_643;
        }

        public function get dirHead(): int {
            return var_1146;
        }

        public function get isMoving(): Boolean {
            return var_1257;
        }

        public function get canStandUp(): Boolean {
            return var_1168;
        }

        public function get actions(): Array {
            return var_531.slice();
        }
    }
}
