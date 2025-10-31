package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.moderation.IssuePickFailedMessageEventParser

    [SecureSWF(rename="true")]
    public class IssuePickFailedMessageEvent extends MessageEvent implements IMessageEvent {

        public function IssuePickFailedMessageEvent(param1: Function) {
            super(param1, IssuePickFailedMessageEventParser);
        }

        public function getParser(): IssuePickFailedMessageEventParser {
            return _parser as IssuePickFailedMessageEventParser;
        }
    }
}
