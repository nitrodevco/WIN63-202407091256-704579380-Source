package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1392

    [SecureSWF(rename="true")]
    public class ChatReviewSessionDetachedMessageEvent extends MessageEvent implements IMessageEvent {

        public function ChatReviewSessionDetachedMessageEvent(param1: Function) {
            super(param1, class_1392);
        }
    }
}
