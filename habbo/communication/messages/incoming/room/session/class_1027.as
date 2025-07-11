package com.sulake.habbo.communication.messages.incoming.room.session {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.session.class_1441

    [SecureSWF(rename="true")]
    public class class_1027 extends MessageEvent {

        public function class_1027(param1: Function) {
            super(param1, class_1441);
        }

        public function getParser(): class_1441 {
            return _parser as class_1441;
        }
    }
}
