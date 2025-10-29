package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1342

    [SecureSWF(rename="true")]
    public class HabboUserBadgesMessageEvent extends MessageEvent implements IMessageEvent {

        public function HabboUserBadgesMessageEvent(param1: Function) {
            super(param1, class_1342);
        }

        public function get badges(): Array {
            return (_parser as class_1342).badges;
        }

        public function get userId(): int {
            return (_parser as class_1342).userId;
        }
    }
}
