package com.sulake.habbo.communication.messages.incoming.inventory.furni {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.furni.class_1491

    [SecureSWF(rename="true")]
    public class FurniListAddOrUpdateEvent extends MessageEvent implements IMessageEvent {

        public function FurniListAddOrUpdateEvent(param1: Function) {
            super(param1, class_1491);
        }

        public function getParser(): class_1491 {
            return this._parser as class_1491;
        }
    }
}
