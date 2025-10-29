package com.sulake.habbo.communication.messages.incoming.room.layout {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.layout.class_1163

    [SecureSWF(rename="true")]
    public class RoomOccupiedTilesMessageEvent extends MessageEvent {

        public function RoomOccupiedTilesMessageEvent(param1: Function) {
            super(param1, class_1163);
        }

        public function getParser(): class_1163 {
            return _parser as class_1163;
        }
    }
}
