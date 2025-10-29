package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1137

    [SecureSWF(rename="true")]
    public class RoomMessageNotificationMessageEvent extends MessageEvent implements IMessageEvent {

        public function RoomMessageNotificationMessageEvent(param1: Function) {
            super(param1, class_1137);
        }

        public function getParser(): class_1137 {
            return _parser as class_1137;
        }
    }
}
