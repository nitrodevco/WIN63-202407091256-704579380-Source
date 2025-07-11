package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1341

    [SecureSWF(rename="true")]
    public class class_641 extends MessageEvent {

        public function class_641(param1: Function) {
            super(param1, class_1341);
        }

        public function getParser(): class_1341 {
            return _parser as class_1341;
        }
    }
}
