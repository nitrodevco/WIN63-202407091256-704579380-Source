package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1453

    [SecureSWF(rename="true")]
    public class ChatReviewSessionStartedMessageEvent extends MessageEvent implements IMessageEvent {

        public function ChatReviewSessionStartedMessageEvent(param1: Function) {
            super(param1, class_1453);
        }

        public function getParser(): class_1453 {
            return _parser as class_1453;
        }
    }
}
