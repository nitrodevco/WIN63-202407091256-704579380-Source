package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1471

    [SecureSWF(rename="true")]
    public class class_776 extends MessageEvent {

        public function class_776(param1: Function) {
            super(param1, class_1471);
        }

        public function getParser(): class_1471 {
            return _parser as class_1471;
        }
    }
}
