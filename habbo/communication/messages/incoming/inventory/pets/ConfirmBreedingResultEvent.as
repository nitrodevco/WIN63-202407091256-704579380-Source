package com.sulake.habbo.communication.messages.incoming.inventory.pets {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1272

    [SecureSWF(rename="true")]
    public class ConfirmBreedingResultEvent extends MessageEvent implements IMessageEvent {

        public function ConfirmBreedingResultEvent(param1: Function) {
            super(param1, class_1272);
        }

        public function getParser(): class_1272 {
            return _parser as class_1272;
        }
    }
}
