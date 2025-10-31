package com.sulake.habbo.communication.messages.parser.marketplace {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class MarketplaceBuyOfferResultEventParser implements IMessageParser {

        public function MarketplaceBuyOfferResultEventParser() {
            super();
        }
        private var var_152: int;
        private var var_1150: int = -1;
        private var var_1249: int = -1;
        private var var_900: int = -1;

        public function get result(): int {
            return var_152;
        }

        public function get offerId(): int {
            return var_1150;
        }

        public function get newPrice(): int {
            return var_1249;
        }

        public function get requestedOfferId(): int {
            return var_900;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_152 = param1.readInteger();
            var_1150 = param1.readInteger();
            var_1249 = param1.readInteger();
            var_900 = param1.readInteger();
            return true;
        }
    }
}
