package com.sulake.habbo.communication.messages.parser.room.engine {
    [SecureSWF(rename="true")]
    public class class_1676 {

        public function class_1676(param1: int, param2: Boolean, param3: int, param4: int, param5: int, param6: int, param7: int, param8: int, param9: int, param10: int, param11: Number) {
            super();
            var_517 = param1;
            var_1497 = param2;
            var_836 = param3;
            var_1158 = param4;
            var_877 = param5;
            var_1313 = param6;
            var_1500 = param7;
            var_1320 = param8;
            var_989 = param9;
            var_873 = param10;
            _animationTime = param11;
        }
        private var var_517: int;
        private var var_1497: Boolean;
        private var var_836: int;
        private var var_1158: int;
        private var var_877: int;
        private var var_1313: int;
        private var var_1500: int;
        private var var_1320: int;
        private var var_989: int;
        private var var_873: int;

        private var _animationTime: Number;

        public function get animationTime(): Number {
            return _animationTime;
        }

        public function get itemId(): int {
            return var_517;
        }

        public function get isDirectionRight(): Boolean {
            return var_1497;
        }

        public function get oldWallX(): int {
            return var_836;
        }

        public function get oldWallY(): int {
            return var_1158;
        }

        public function get oldOffsetX(): int {
            return var_877;
        }

        public function get oldOffsetY(): int {
            return var_1313;
        }

        public function get newWallX(): int {
            return var_1500;
        }

        public function get newWallY(): int {
            return var_1320;
        }

        public function get newOffsetX(): int {
            return var_989;
        }

        public function get newOffsetY(): int {
            return var_873;
        }
    }
}
