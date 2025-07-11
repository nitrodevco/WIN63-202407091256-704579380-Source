package com.sulake.habbo.communication.messages.incoming.room.session {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.session.class_1159

    [SecureSWF(rename="true")]
    public class class_1105 extends MessageEvent {

        public function class_1105(param1: Function) {
            super(param1, class_1159);
        }

        public function getParser(): class_1159 {
            return _parser as class_1159;
        }
    }
}
