package com.sulake.habbo.communication.messages.incoming.room.session {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.session.class_1428

    [SecureSWF(rename="true")]
    public class class_875 extends MessageEvent {

        public function class_875(param1: Function) {
            super(param1, class_1428);
        }

        public function getParser(): class_1428 {
            return _parser as class_1428;
        }
    }
}
