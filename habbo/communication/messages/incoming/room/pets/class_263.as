package com.sulake.habbo.communication.messages.incoming.room.pets {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.pets.class_1456

    [SecureSWF(rename="true")]
    public class class_263 extends MessageEvent implements IMessageEvent {

        public function class_263(param1: Function) {
            super(param1, class_1456);
        }

        public function getParser(): class_1456 {
            return _parser as class_1456;
        }
    }
}
