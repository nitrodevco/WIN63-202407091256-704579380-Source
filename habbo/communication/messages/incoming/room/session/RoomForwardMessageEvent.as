package com.sulake.habbo.communication.messages.incoming.room.session {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.session.class_1208

    [SecureSWF(rename="true")]
    public class RoomForwardMessageEvent extends MessageEvent {

        public function RoomForwardMessageEvent(param1: Function) {
            super(param1, class_1208);
        }

        public function getParser(): class_1208 {
            return _parser as class_1208;
        }
    }
}
