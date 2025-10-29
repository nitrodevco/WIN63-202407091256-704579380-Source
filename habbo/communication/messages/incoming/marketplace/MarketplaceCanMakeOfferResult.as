package com.sulake.habbo.communication.messages.incoming.marketplace {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.marketplace.class_1602

    [SecureSWF(rename="true")]
    public class MarketplaceCanMakeOfferResult extends MessageEvent implements IMessageEvent {

        public function MarketplaceCanMakeOfferResult(param1: Function) {
            super(param1, class_1602);
        }

        public function getParser(): class_1602 {
            return _parser as class_1602;
        }
    }
}
