package com.sulake.habbo.communication.messages.incoming.availability {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.availability.class_1255

    [SecureSWF(rename="true")]
    public class InfoHotelClosingMessageEvent extends MessageEvent implements IMessageEvent {

        public function InfoHotelClosingMessageEvent(param1: Function) {
            super(param1, class_1255);
        }

        public function getParser(): class_1255 {
            return _parser as class_1255;
        }
    }
}
