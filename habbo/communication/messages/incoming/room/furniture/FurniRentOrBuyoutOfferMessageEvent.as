package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1381

    [SecureSWF(rename="true")]
    public class FurniRentOrBuyoutOfferMessageEvent extends MessageEvent implements IMessageEvent {

        public function FurniRentOrBuyoutOfferMessageEvent(param1: Function) {
            super(param1, class_1381);
        }

        public function getParser(): class_1381 {
            return _parser as class_1381;
        }
    }
}
