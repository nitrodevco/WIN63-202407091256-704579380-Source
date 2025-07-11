package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1529

    [SecureSWF(rename="true")]
    public class class_671 extends MessageEvent {

        public function class_671(param1: Function) {
            super(param1, class_1529);
        }

        public function getParser(): class_1529 {
            return _parser as class_1529;
        }
    }
}
