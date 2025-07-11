package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1626

    [SecureSWF(rename="true")]
    public class class_447 extends MessageEvent {

        public function class_447(param1: Function) {
            super(param1, class_1626);
        }

        public function getParser(): class_1626 {
            return _parser as class_1626;
        }
    }
}
