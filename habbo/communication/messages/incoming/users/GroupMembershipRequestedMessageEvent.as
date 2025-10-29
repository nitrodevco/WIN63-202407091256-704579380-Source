package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1631

    [SecureSWF(rename="true")]
    public class GroupMembershipRequestedMessageEvent extends MessageEvent implements IMessageEvent {

        public function GroupMembershipRequestedMessageEvent(param1: Function) {
            super(param1, class_1631);
        }

        public function getParser(): class_1631 {
            return class_1631(_parser);
        }
    }
}
