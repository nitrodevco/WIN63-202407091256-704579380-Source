package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1327

    [SecureSWF(rename="true")]
    public class TargetedOfferNotFoundEvent extends MessageEvent implements IMessageEvent {

        public function TargetedOfferNotFoundEvent(param1: Function) {
            super(param1, class_1327);
        }

        public function getParser(): class_1327 {
            return this._parser as class_1327;
        }
    }
}
