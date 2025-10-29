package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1188

    [SecureSWF(rename="true")]
    public class LimitedOfferAppearingNextMessageEvent extends MessageEvent implements IMessageEvent {

        public function LimitedOfferAppearingNextMessageEvent(param1: Function) {
            super(param1, class_1188);
        }

        public function getParser(): class_1188 {
            return this._parser as class_1188;
        }
    }
}
