package com.sulake.habbo.communication.messages.incoming.marketplace {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.marketplace.class_1317

    [SecureSWF(rename="true")]
    public class MarketPlaceOwnOffersEvent extends MessageEvent implements IMessageEvent {

        public function MarketPlaceOwnOffersEvent(param1: Function) {
            super(param1, class_1317);
        }

        public function getParser(): class_1317 {
            return _parser as class_1317;
        }
    }
}
