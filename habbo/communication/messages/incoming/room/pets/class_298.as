package com.sulake.habbo.communication.messages.incoming.room.pets {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.pets.class_1451

    [SecureSWF(rename="true")]
    public class class_298 extends MessageEvent implements IMessageEvent {

        public function class_298(param1: Function) {
            super(param1, class_1451);
        }

        public function getParser(): class_1451 {
            return _parser as class_1451;
        }
    }
}
