package com.sulake.habbo.communication.messages.incoming.inventory.pets {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1569

    [SecureSWF(rename="true")]
    public class NestBreedingSuccessEvent extends MessageEvent implements IMessageEvent {

        public function NestBreedingSuccessEvent(param1: Function) {
            super(param1, class_1569);
        }

        public function getParser(): class_1569 {
            return _parser as class_1569;
        }
    }
}
