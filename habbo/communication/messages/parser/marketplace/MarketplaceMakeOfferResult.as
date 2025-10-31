package com.sulake.habbo.communication.messages.parser.marketplace {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class MarketplaceMakeOfferResult implements IMessageParser {

        public function MarketplaceMakeOfferResult() {
            super();
        }
        private var var_152: int;

        public function get result(): int {
            return var_152;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_152 = param1.readInteger();
            return true;
        }
    }
}
