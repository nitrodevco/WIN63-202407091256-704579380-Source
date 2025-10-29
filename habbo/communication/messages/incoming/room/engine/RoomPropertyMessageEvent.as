package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1437

    [SecureSWF(rename="true")]
    public class RoomPropertyMessageEvent extends MessageEvent {

        public function RoomPropertyMessageEvent(param1: Function) {
            super(param1, class_1437);
        }

        public function getParser(): class_1437 {
            return _parser as class_1437;
        }
    }
}
