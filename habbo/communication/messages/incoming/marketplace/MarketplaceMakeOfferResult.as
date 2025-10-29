package com.sulake.habbo.communication.messages.incoming.marketplace {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.marketplace.class_1518

    [SecureSWF(rename="true")]
    public class MarketplaceMakeOfferResult extends MessageEvent implements IMessageEvent {

        public function MarketplaceMakeOfferResult(param1: Function) {
            super(param1, class_1518);
        }

        public function getParser(): class_1518 {
            return _parser as class_1518;
        }
    }
}
