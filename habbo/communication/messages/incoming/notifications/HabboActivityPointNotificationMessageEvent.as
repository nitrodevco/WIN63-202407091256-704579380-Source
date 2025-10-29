package com.sulake.habbo.communication.messages.incoming.notifications {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.notifications.class_1630

    [SecureSWF(rename="true")]
    public class HabboActivityPointNotificationMessageEvent extends MessageEvent implements IMessageEvent {

        public function HabboActivityPointNotificationMessageEvent(param1: Function) {
            super(param1, class_1630);
        }

        public function get amount(): int {
            return (_parser as class_1630).amount;
        }

        public function get change(): int {
            return (_parser as class_1630).change;
        }

        public function get type(): int {
            return (_parser as class_1630).type;
        }
    }
}
