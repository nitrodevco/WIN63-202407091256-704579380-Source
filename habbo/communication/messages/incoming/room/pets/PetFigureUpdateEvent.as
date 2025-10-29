package com.sulake.habbo.communication.messages.incoming.room.pets {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.pets.class_1310

    [SecureSWF(rename="true")]
    public class PetFigureUpdateEvent extends MessageEvent implements IMessageEvent {

        public function PetFigureUpdateEvent(param1: Function) {
            super(param1, class_1310);
        }

        public function getParser(): class_1310 {
            return _parser as class_1310;
        }
    }
}
