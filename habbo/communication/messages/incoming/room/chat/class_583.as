package com.sulake.habbo.communication.messages.incoming.room.chat {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.chat.class_1253

    [SecureSWF(rename="true")]
    public class class_583 extends MessageEvent {

        public function class_583(param1: Function) {
            super(param1, class_1253);
        }

        public function getParser(): class_1253 {
            return _parser as class_1253;
        }
    }
}
