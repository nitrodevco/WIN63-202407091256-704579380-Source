package com.sulake.habbo.communication.messages.incoming.room.engine {
    [SecureSWF(rename="true")]
    public class class_1766 {

        public function class_1766(param1: int, param2: String) {
            super();
            var_280 = param1;
            var_199 = param2;
            var _loc3_: Number = parseFloat(var_199);
            if (!isNaN(_loc3_)) {
                var_149 = int(var_199);
            }
        }
        private var var_280: int = 0;
        private var var_199: String;
        private var var_149: int;

        public function get id(): int {
            return var_280;
        }

        public function get itemData(): String {
            return var_199;
        }

        public function get state(): int {
            return var_149;
        }
    }
}
