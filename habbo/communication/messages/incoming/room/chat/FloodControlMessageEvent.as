package com.sulake.habbo.communication.messages.incoming.room.chat {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.chat.class_1558

    [SecureSWF(rename="true")]
    public class FloodControlMessageEvent extends MessageEvent {

        public function FloodControlMessageEvent(param1: Function) {
            super(param1, class_1558);
        }

        public function getParser(): class_1558 {
            return _parser as class_1558;
        }
    }
}
