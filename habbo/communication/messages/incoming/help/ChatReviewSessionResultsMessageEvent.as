package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1584

    [SecureSWF(rename="true")]
    public class ChatReviewSessionResultsMessageEvent extends MessageEvent implements IMessageEvent {

        public function ChatReviewSessionResultsMessageEvent(param1: Function) {
            super(param1, class_1584);
        }

        public function getParser(): class_1584 {
            return _parser as class_1584;
        }
    }
}
