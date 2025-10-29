package com.sulake.habbo.communication.messages.incoming.inventory.pets {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1213

    [SecureSWF(rename="true")]
    public class PetInventoryEvent extends MessageEvent implements IMessageEvent {

        public function PetInventoryEvent(param1: Function) {
            super(param1, class_1213);
        }

        public function getParser(): class_1213 {
            return _parser as class_1213;
        }
    }
}
