package com.sulake.habbo.communication.messages.incoming.gifts {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.gifts.class_1398

    [SecureSWF(rename="true")]
    public class TryPhoneNumberResultMessageEvent extends MessageEvent implements IMessageEvent {

        public function TryPhoneNumberResultMessageEvent(param1: Function) {
            super(param1, class_1398);
        }

        public function getParser(): class_1398 {
            return _parser as class_1398;
        }
    }
}
