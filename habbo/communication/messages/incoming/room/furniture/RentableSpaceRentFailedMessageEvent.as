package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1449

    [SecureSWF(rename="true")]
    public class RentableSpaceRentFailedMessageEvent extends MessageEvent {

        public function RentableSpaceRentFailedMessageEvent(param1: Function) {
            super(param1, class_1449);
        }

        public function getParser(): class_1449 {
            return parser as class_1449;
        }
    }
}
