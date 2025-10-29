package com.sulake.habbo.communication.messages.incoming.room.chat {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.chat.class_1344

    [SecureSWF(rename="true")]
    public class ShoutMessageEvent extends MessageEvent {

        public function ShoutMessageEvent(param1: Function) {
            super(param1, class_1344);
        }

        public function getParser(): class_1344 {
            return _parser as class_1344;
        }
    }
}
