package com.sulake.habbo.communication.messages.incoming.room.pets {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.pets.class_1369

    [SecureSWF(rename="true")]
    public class PetExperienceEvent extends MessageEvent implements IMessageEvent {

        public function PetExperienceEvent(param1: Function) {
            super(param1, class_1369);
        }

        public function getParser(): class_1369 {
            return _parser as class_1369;
        }
    }
}
