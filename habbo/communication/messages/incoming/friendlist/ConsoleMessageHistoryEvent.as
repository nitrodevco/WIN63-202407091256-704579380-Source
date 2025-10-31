package com.sulake.habbo.communication.messages.incoming.friendlist {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.friendlist.ConsoleMessageHistoryEventParser

    [SecureSWF(rename="true")]
    public class ConsoleMessageHistoryEvent extends MessageEvent implements IMessageEvent {

        public function ConsoleMessageHistoryEvent(param1: Function) {
            super(param1, ConsoleMessageHistoryEventParser);
        }

        public function getParser(): ConsoleMessageHistoryEventParser {
            return this._parser as ConsoleMessageHistoryEventParser;
        }
    }
}
