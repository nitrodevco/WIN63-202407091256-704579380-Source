package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1396

    [SecureSWF(rename="true")]
    public class RentableSpaceStatusMessageEvent extends MessageEvent {

        public function RentableSpaceStatusMessageEvent(param1: Function) {
            super(param1, class_1396);
        }

        public function getParser(): class_1396 {
            return parser as class_1396;
        }
    }
}
