package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1214

    [SecureSWF(rename="true")]
    public class class_660 extends MessageEvent {

        public function class_660(param1: Function) {
            super(param1, class_1214);
        }

        public function getParser(): class_1214 {
            return _parser as class_1214;
        }
    }
}
