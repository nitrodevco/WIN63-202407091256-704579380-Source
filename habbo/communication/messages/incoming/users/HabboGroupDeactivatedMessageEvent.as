package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1205

    [SecureSWF(rename="true")]
    public class HabboGroupDeactivatedMessageEvent extends MessageEvent implements IMessageEvent {

        public function HabboGroupDeactivatedMessageEvent(param1: Function) {
            super(param1, class_1205);
        }

        public function get groupId(): int {
            return class_1205(_parser).groupId;
        }
    }
}
