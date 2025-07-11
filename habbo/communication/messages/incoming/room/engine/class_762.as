package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1612

    [SecureSWF(rename="true")]
    public class class_762 extends MessageEvent {

        public function class_762(param1: Function) {
            super(param1, class_1612);
        }

        public function getParser(): class_1612 {
            return _parser as class_1612;
        }
    }
}
