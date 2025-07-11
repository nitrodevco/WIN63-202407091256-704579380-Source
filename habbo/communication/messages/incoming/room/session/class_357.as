package com.sulake.habbo.communication.messages.incoming.room.session {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.session.class_1515

    [SecureSWF(rename="true")]
    public class class_357 extends MessageEvent {

        public function class_357(param1: Function) {
            super(param1, class_1515);
        }

        public function getParser(): class_1515 {
            return _parser as class_1515;
        }
    }
}
