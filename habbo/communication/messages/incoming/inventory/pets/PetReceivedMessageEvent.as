package com.sulake.habbo.communication.messages.incoming.inventory.pets {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1438

    [SecureSWF(rename="true")]
    public class PetReceivedMessageEvent extends MessageEvent implements IMessageEvent {

        public function PetReceivedMessageEvent(param1: Function) {
            super(param1, class_1438);
        }

        public function getParser(): class_1438 {
            return _parser as class_1438;
        }
    }
}
