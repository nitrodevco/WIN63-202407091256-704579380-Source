package com.sulake.habbo.communication.messages.incoming.gifts {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.gifts.TryVerificationCodeResultMessageEventParser

    [SecureSWF(rename="true")]
    public class TryVerificationCodeResultMessageEvent extends MessageEvent implements IMessageEvent {

        public function TryVerificationCodeResultMessageEvent(param1: Function) {
            super(param1, TryVerificationCodeResultMessageEventParser);
        }

        public function getParser(): TryVerificationCodeResultMessageEventParser {
            return _parser as TryVerificationCodeResultMessageEventParser;
        }
    }
}
