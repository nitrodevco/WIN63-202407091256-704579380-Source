package com.sulake.habbo.communication.messages.incoming.inventory.badges {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgeReceivedEventParser

    [SecureSWF(rename="true")]
    public class BadgeReceivedEvent extends MessageEvent {

        public function BadgeReceivedEvent(param1: Function) {
            super(param1, BadgeReceivedEventParser);
        }

        public function getParser(): BadgeReceivedEventParser {
            return _parser as BadgeReceivedEventParser;
        }
    }
}
