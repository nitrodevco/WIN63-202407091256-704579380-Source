package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1639 {

        public function class_1639(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            super();
            var_929 = param1.readInteger();
            var_1509 = param1.readInteger();
            var_1037 = param1.readInteger();
            var_1105 = param1.readInteger();
            var_759 = [];
            var _loc2_: int = param1.readInteger();
            while (_loc3_ < _loc2_) {
                var_759.push(param1.readInteger());
                _loc3_++;
            }
        }
        private var var_929: int;
        private var var_1509: int;
        private var var_1037: int;
        private var var_1105: int;
        private var var_759: Array;

        public function get maxPurchaseSize(): int {
            return var_929;
        }

        public function get bundleSize(): int {
            return var_1509;
        }

        public function get bundleDiscountSize(): int {
            return var_1037;
        }

        public function get bonusThreshold(): int {
            return var_1105;
        }

        public function get additionalBonusDiscountThresholdQuantities(): Array {
            return var_759;
        }
    }
}
