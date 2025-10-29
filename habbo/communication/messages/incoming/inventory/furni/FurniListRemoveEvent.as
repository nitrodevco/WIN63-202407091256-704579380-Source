package com.sulake.habbo.communication.messages.incoming.inventory.furni {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.furni.class_1611

    [SecureSWF(rename="true")]
    public class FurniListRemoveEvent extends MessageEvent implements IMessageEvent {

        public function FurniListRemoveEvent(param1: Function) {
            super(param1, class_1611);
        }

        public function getParser(): class_1611 {
            return this._parser as class_1611;
        }
    }
}
