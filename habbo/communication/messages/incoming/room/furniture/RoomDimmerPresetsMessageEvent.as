package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1258

    [SecureSWF(rename="true")]
    public class RoomDimmerPresetsMessageEvent extends MessageEvent {

        public function RoomDimmerPresetsMessageEvent(param1: Function) {
            super(param1, class_1258);
        }

        public function getParser(): class_1258 {
            return _parser as class_1258;
        }
    }
}
