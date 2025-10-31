package com.sulake.habbo.communication.messages.parser.marketplace {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class MarketplaceConfigurationEventParser implements IMessageParser {

        public function MarketplaceConfigurationEventParser() {
            super();
        }
        private var var_1479: Boolean;
        private var var_1181: int;
        private var var_1144: int;
        private var var_664: int;
        private var var_1033: int;
        private var var_969: int;
        private var var_1259: int;
        private var var_1323: int;

        private var _offerMaxPrice: int;

        public function get offerMaxPrice(): int {
            return _offerMaxPrice;
        }

        private var _offerMinPrice: int;

        public function get offerMinPrice(): int {
            return _offerMinPrice;
        }

        private var _expirationHours: int;

        public function get expirationHours(): int {
            return _expirationHours;
        }

        public function get isEnabled(): Boolean {
            return var_1479;
        }

        public function get commission(): int {
            return var_1181;
        }

        public function get tokenBatchPrice(): int {
            return var_1144;
        }

        public function get tokenBatchSize(): int {
            return var_664;
        }

        public function get averagePricePeriod(): int {
            return var_1033;
        }

        public function get tokensBatchSize(): int {
            return var_664;
        }

        public function get sellingFeePercentage(): int {
            return var_969;
        }

        public function get revenueLimit(): int {
            return var_1259;
        }

        public function get halfTaxLimit(): int {
            return var_1323;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1479 = param1.readBoolean();
            var_1181 = param1.readInteger();
            var_1144 = param1.readInteger();
            var_664 = param1.readInteger();
            _offerMinPrice = param1.readInteger();
            _offerMaxPrice = param1.readInteger();
            _expirationHours = param1.readInteger();
            var_1033 = param1.readInteger();
            var_969 = param1.readInteger();
            var_1259 = param1.readInteger();
            var_1323 = param1.readInteger();
            return true;
        }
    }
}
