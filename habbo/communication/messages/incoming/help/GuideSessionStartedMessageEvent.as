package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionStartedMessageEventParser

    [SecureSWF(rename="true")]
    public class GuideSessionStartedMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuideSessionStartedMessageEvent(param1: Function) {
            super(param1, GuideSessionStartedMessageEventParser);
        }

        public function getParser(): GuideSessionStartedMessageEventParser {
            return _parser as GuideSessionStartedMessageEventParser;
        }
    }
}
