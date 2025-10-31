package com.sulake.habbo.communication.messages.parser.marketplace {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class MarketplaceCancelOfferResultEventParser implements IMessageParser {

        public function MarketplaceCancelOfferResultEventParser() {
            super();
        }
        private var var_258: Boolean;

        private var _offerId: int;

        public function get offerId(): int {
            return _offerId;
        }

        public function get success(): Boolean {
            return var_258;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _offerId = param1.readInteger();
            var_258 = param1.readBoolean();
            return true;
        }
    }
}
