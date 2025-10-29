package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.moderation.class_1285

    [SecureSWF(rename="true")]
    public class IssueDeletedMessageEvent extends MessageEvent implements IMessageEvent {

        public function IssueDeletedMessageEvent(param1: Function) {
            super(param1, class_1285);
        }

        public function getParser(): class_1285 {
            return _parser as class_1285;
        }
    }
}
