package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1339

    [SecureSWF(rename="true")]
    public class RoomEntryInfoMessageEvent extends MessageEvent implements IMessageEvent {

        public function RoomEntryInfoMessageEvent(param1: Function) {
            super(param1, class_1339);
        }

        public function getParser(): class_1339 {
            return _parser as class_1339;
        }
    }
}
