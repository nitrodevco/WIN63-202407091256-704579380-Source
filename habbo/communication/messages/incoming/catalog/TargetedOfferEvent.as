package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1402

    [SecureSWF(rename="true")]
    public class TargetedOfferEvent extends MessageEvent implements IMessageEvent {

        public function TargetedOfferEvent(param1: Function) {
            super(param1, class_1402);
        }

        public function getParser(): class_1402 {
            return this._parser as class_1402;
        }
    }
}
