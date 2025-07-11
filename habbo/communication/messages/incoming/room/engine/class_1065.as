package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1424

    [SecureSWF(rename="true")]
    public class class_1065 extends MessageEvent {

        public function class_1065(param1: Function) {
            super(param1, class_1424);
        }

        public function getParser(): class_1424 {
            return _parser as class_1424;
        }
    }
}
