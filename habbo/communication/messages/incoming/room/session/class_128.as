package com.sulake.habbo.communication.messages.incoming.room.session {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.session.class_1208

    [SecureSWF(rename="true")]
    public class class_128 extends MessageEvent {

        public function class_128(param1: Function) {
            super(param1, class_1208);
        }

        public function getParser(): class_1208 {
            return _parser as class_1208;
        }
    }
}
