package com.sulake.habbo.communication.messages.incoming.room.layout {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.layout.class_1609

    [SecureSWF(rename="true")]
    public class RoomEntryTileMessageEvent extends MessageEvent {

        public function RoomEntryTileMessageEvent(param1: Function) {
            super(param1, class_1609);
        }

        public function getParser(): class_1609 {
            return _parser as class_1609;
        }
    }
}
