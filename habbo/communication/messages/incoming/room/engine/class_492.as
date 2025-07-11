package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1226

    [SecureSWF(rename="true")]
    public class class_492 extends MessageEvent {

        public function class_492(param1: Function) {
            super(param1, class_1226);
        }

        public function getParser(): class_1226 {
            return _parser as class_1226;
        }
    }
}
