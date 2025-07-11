package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1646 extends class_1645 {

        public function class_1646(param1: IMessageDataWrapper) {
            super(param1);
            var_679 = param1.readInteger();
            var_1441 = param1.readInteger();
            var_1083 = param1.readInteger();
            var_934 = param1.readInteger();
        }
        private var var_679: int;
        private var var_1441: int;
        private var var_1083: int;
        private var var_934: int;

        public function get originalPrice(): int {
            return var_679 * months;
        }

        public function get originalActivityPointPrice(): int {
            return var_1441 * months;
        }

        public function get originalActivityPointType(): int {
            return var_1083;
        }

        public function get discountCreditAmount(): int {
            return var_679 * months - this.priceCredits;
        }

        public function get discountActivityPointAmount(): int {
            return originalActivityPointPrice * months - this.priceActivityPoints;
        }

        public function get subscriptionDaysLeft(): int {
            return var_934;
        }
    }
}
