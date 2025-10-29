package com.sulake.habbo.communication.messages.incoming.room.chat {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.chat.class_1489

    [SecureSWF(rename="true")]
    public class UserTypingMessageEvent extends MessageEvent {

        public function UserTypingMessageEvent(param1: Function) {
            super(param1, class_1489);
        }

        public function getParser(): class_1489 {
            return _parser as class_1489;
        }
    }
}
