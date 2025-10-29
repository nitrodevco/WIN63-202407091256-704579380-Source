package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.moderation.class_1533

    [SecureSWF(rename="true")]
    public class IssuePickFailedMessageEvent extends MessageEvent implements IMessageEvent {

        public function IssuePickFailedMessageEvent(param1: Function) {
            super(param1, class_1533);
        }

        public function getParser(): class_1533 {
            return _parser as class_1533;
        }
    }
}
