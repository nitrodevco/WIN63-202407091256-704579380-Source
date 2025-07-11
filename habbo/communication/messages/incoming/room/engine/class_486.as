package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1221

    [SecureSWF(rename="true")]
    public class class_486 extends MessageEvent {

        public function class_486(param1: Function) {
            super(param1, class_1221);
        }

        public function getParser(): class_1221 {
            return _parser as class_1221;
        }
    }
}
