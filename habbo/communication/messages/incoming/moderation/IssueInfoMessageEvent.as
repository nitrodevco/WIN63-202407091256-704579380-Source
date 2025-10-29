package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.moderation.class_1618

    [SecureSWF(rename="true")]
    public class IssueInfoMessageEvent extends MessageEvent implements IMessageEvent {

        public function IssueInfoMessageEvent(param1: Function) {
            super(param1, class_1618);
        }

        public function getParser(): class_1618 {
            return _parser as class_1618;
        }
    }
}
