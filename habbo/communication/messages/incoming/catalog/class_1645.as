package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1645 {

        public function class_1645(param1: IMessageDataWrapper) {
            super();
            _offerId = param1.readInteger();
            var_394 = param1.readString();
            param1.readBoolean();
            var_896 = param1.readInteger();
            var_1327 = param1.readInteger();
            var_1387 = param1.readInteger();
            var_1294 = param1.readBoolean();
            var_1229 = param1.readInteger();
            var_772 = param1.readInteger();
            var_968 = param1.readBoolean();
            var_1190 = param1.readInteger();
            var_557 = param1.readInteger();
            _month = param1.readInteger();
            var_1404 = param1.readInteger();
        }
        private var var_394: String;

        private var var_896: int;

        private var var_1327: int;

        private var var_1387: int;

        private var var_1294: Boolean;

        private var var_1229: int;

        private var var_772: int;

        private var var_1190: int;

        private var var_557: int;
        private var var_1404: int;
        private var var_968: Boolean;

        private var _offerId: int;

        public function get offerId(): int {
            return _offerId;
        }

        private var _month: int;

        public function get month(): int {
            return _month;
        }

        public function get productCode(): String {
            return var_394;
        }

        public function get priceCredits(): int {
            return var_896;
        }

        public function get vip(): Boolean {
            return var_1294;
        }

        public function get months(): int {
            return var_1229;
        }

        public function get extraDays(): int {
            return var_772;
        }

        public function get daysLeftAfterPurchase(): int {
            return var_1190;
        }

        public function get year(): int {
            return var_557;
        }

        public function get day(): int {
            return var_1404;
        }

        public function get priceActivityPoints(): int {
            return var_1327;
        }

        public function get priceActivityPointType(): int {
            return var_1387;
        }

        public function get isGiftable(): Boolean {
            return var_968;
        }
    }
}
