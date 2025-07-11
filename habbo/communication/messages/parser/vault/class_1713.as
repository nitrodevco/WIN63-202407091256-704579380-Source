package com.sulake.habbo.communication.messages.parser.vault {
    [SecureSWF(rename="true")]
    public class class_1713 {

        public function class_1713(param1: int, param2: int, param3: int, param4: String) {
            super();
            var_773 = param1;
            var_1326 = param2;
            _amount = param3;
            var_394 = param4;
        }
        private var var_773: int;
        private var var_1326: int;
        private var var_394: String;

        private var _amount: int;

        public function get amount(): int {
            return _amount;
        }

        public function get rewardCategory(): int {
            return var_773;
        }

        public function get rewardType(): int {
            return var_1326;
        }

        public function get productCode(): String {
            return var_394;
        }
    }
}
