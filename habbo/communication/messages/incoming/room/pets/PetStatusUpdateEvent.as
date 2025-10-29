package com.sulake.habbo.communication.messages.incoming.room.pets {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.pets.class_1384

    [SecureSWF(rename="true")]
    public class PetStatusUpdateEvent extends MessageEvent implements IMessageEvent {

        public function PetStatusUpdateEvent(param1: Function) {
            super(param1, class_1384);
        }

        public function getParser(): class_1384 {
            return _parser as class_1384;
        }
    }
}
