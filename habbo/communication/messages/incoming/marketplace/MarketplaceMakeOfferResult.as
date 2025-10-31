package com.sulake.habbo.communication.messages.incoming.marketplace {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceMakeOfferResult

    [SecureSWF(rename="true")]
    public class MarketplaceMakeOfferResult extends MessageEvent implements IMessageEvent {

        public function MarketplaceMakeOfferResult(param1: Function) {
            super(param1, MarketplaceMakeOfferResult);
        }

        public function getParser(): MarketplaceMakeOfferResult {
            return _parser as MarketplaceMakeOfferResult;
        }
    }
}
