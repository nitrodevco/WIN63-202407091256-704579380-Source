package com.sulake.habbo.communication.messages.incoming.marketplace {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.marketplace.class_1479

    [SecureSWF(rename="true")]
    public class MarketplaceBuyOfferResultEvent extends MessageEvent implements IMessageEvent {

        public function MarketplaceBuyOfferResultEvent(param1: Function) {
            super(param1, class_1479);
        }

        public function getParser(): class_1479 {
            return _parser as class_1479;
        }
    }
}
