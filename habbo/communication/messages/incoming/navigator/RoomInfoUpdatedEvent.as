package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1468

    [SecureSWF(rename="true")]
    public class RoomInfoUpdatedEvent extends MessageEvent implements IMessageEvent {

        public function RoomInfoUpdatedEvent(param1: Function) {
            super(param1, class_1468);
        }

        public function getParser(): class_1468 {
            return this._parser as class_1468;
        }
    }
}
