package com.sulake.habbo.communication.messages.incoming.room.session {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.session.class_1459

    [SecureSWF(rename="true")]
    public class class_566 extends MessageEvent {

        public function class_566(param1: Function) {
            super(param1, class_1459);
        }

        public function getParser(): class_1459 {
            return _parser as class_1459;
        }
    }
}
