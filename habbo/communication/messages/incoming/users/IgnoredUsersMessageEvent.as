package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1490

    [SecureSWF(rename="true")]
    public class IgnoredUsersMessageEvent extends MessageEvent implements IMessageEvent {

        public function IgnoredUsersMessageEvent(param1: Function) {
            super(param1, class_1490);
        }

        public function get ignoredUserIds(): Array {
            return (_parser as class_1490).ignoredUsers;
        }
    }
}
