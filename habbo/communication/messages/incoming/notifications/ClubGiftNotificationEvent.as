package com.sulake.habbo.communication.messages.incoming.notifications {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.notifications.class_1452

    [SecureSWF(rename="true")]
    public class ClubGiftNotificationEvent extends MessageEvent implements IMessageEvent {

        public function ClubGiftNotificationEvent(param1: Function) {
            super(param1, class_1452);
        }

        public function getParser(): class_1452 {
            return _parser as class_1452;
        }
    }
}
