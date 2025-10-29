package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1291

    [SecureSWF(rename="true")]
    public class PurchaseErrorMessageEvent extends MessageEvent implements IMessageEvent {

        public function PurchaseErrorMessageEvent(param1: Function) {
            super(param1, class_1291);
        }

        public function getParser(): class_1291 {
            return this._parser as class_1291;
        }
    }
}
