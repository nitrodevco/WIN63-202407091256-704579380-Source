package com.sulake.habbo.communication.messages.incoming.availability {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.availability.class_1579

    [SecureSWF(rename="true")]
    public class AvailabilityStatusMessageEvent extends MessageEvent implements IMessageEvent {

        public function AvailabilityStatusMessageEvent(param1: Function) {
            super(param1, class_1579);
        }

        public function getParser(): class_1579 {
            return _parser as class_1579;
        }
    }
}
