package com.sulake.habbo.communication.messages.incoming.marketplace {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCanMakeOfferResult

    [SecureSWF(rename="true")]
    public class MarketplaceCanMakeOfferResult extends MessageEvent implements IMessageEvent {

        public function MarketplaceCanMakeOfferResult(param1: Function) {
            super(param1, MarketplaceCanMakeOfferResult);
        }

        public function getParser(): MarketplaceCanMakeOfferResult {
            return _parser as MarketplaceCanMakeOfferResult;
        }
    }
}
