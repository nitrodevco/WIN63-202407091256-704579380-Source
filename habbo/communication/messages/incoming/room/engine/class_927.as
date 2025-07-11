package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1465

    [SecureSWF(rename="true")]
    public class class_927 extends MessageEvent {

        public function class_927(param1: Function) {
            super(param1, class_1465);
        }

        public function getParser(): class_1465 {
            return _parser as class_1465;
        }
    }
}
