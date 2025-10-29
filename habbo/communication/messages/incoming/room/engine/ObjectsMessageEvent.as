package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1432

    [SecureSWF(rename="true")]
    public class ObjectsMessageEvent extends MessageEvent {

        public function ObjectsMessageEvent(param1: Function) {
            super(param1, class_1432);
        }

        public function getParser(): class_1432 {
            return _parser as class_1432;
        }
    }
}
