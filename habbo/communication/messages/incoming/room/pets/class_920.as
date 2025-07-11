package com.sulake.habbo.communication.messages.incoming.room.pets {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.pets.class_1580

    [SecureSWF(rename="true")]
    public class class_920 extends MessageEvent implements IMessageEvent {

        public function class_920(param1: Function) {
            super(param1, class_1580);
        }

        public function getParser(): class_1580 {
            return _parser as class_1580;
        }
    }
}
