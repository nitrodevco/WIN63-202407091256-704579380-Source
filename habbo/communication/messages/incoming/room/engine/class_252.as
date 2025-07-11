package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1412

    [SecureSWF(rename="true")]
    public class class_252 extends MessageEvent {

        public function class_252(param1: Function) {
            super(param1, class_1412);
        }

        public function getParser(): class_1412 {
            return _parser as class_1412;
        }
    }
}
