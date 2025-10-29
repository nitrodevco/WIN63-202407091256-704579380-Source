package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1315

    [SecureSWF(rename="true")]
    public class GiftReceiverNotFoundEvent extends MessageEvent implements IMessageEvent {

        public function GiftReceiverNotFoundEvent(param1: Function) {
            super(param1, class_1315);
        }

        public function getParser(): class_1315 {
            return this._parser as class_1315;
        }
    }
}
