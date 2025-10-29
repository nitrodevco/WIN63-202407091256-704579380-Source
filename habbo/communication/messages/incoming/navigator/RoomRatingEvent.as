package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1523

    [SecureSWF(rename="true")]
    public class RoomRatingEvent extends MessageEvent implements IMessageEvent {

        public function RoomRatingEvent(param1: Function) {
            super(param1, class_1523);
        }

        public function getParser(): class_1523 {
            return this._parser as class_1523;
        }
    }
}
