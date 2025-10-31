package com.sulake.habbo.communication.messages.incoming.room.bots {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.bots.BotErrorEventParser

    [SecureSWF(rename="true")]
    public class BotErrorEvent extends MessageEvent implements IMessageEvent {

        public function BotErrorEvent(param1: Function) {
            super(param1, BotErrorEventParser);
        }

        public function getParser(): BotErrorEventParser {
            return _parser as BotErrorEventParser;
        }
    }
}
