package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1371

    [SecureSWF(rename="true")]
    public class CustomUserNotificationMessageEvent extends MessageEvent {

        public function CustomUserNotificationMessageEvent(param1: Function) {
            super(param1, class_1371);
        }

        public function getParser(): class_1371 {
            return parser as class_1371;
        }
    }
}
