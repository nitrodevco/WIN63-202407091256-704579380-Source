package com.sulake.habbo.communication.messages.incoming.inventory.pets {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1149

    [SecureSWF(rename="true")]
    public class GoToBreedingNestFailureEvent extends MessageEvent implements IMessageEvent {

        public function GoToBreedingNestFailureEvent(param1: Function) {
            super(param1, class_1149);
        }

        public function getParser(): class_1149 {
            return _parser as class_1149;
        }
    }
}
