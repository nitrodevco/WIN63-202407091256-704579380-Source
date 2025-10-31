package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.HabboGroupJoinFailedMessageEventParser

    [SecureSWF(rename="true")]
    public class HabboGroupJoinFailedMessageEvent extends MessageEvent implements IMessageEvent {

        public function HabboGroupJoinFailedMessageEvent(param1: Function) {
            super(param1, HabboGroupJoinFailedMessageEventParser);
        }

        public function get reason(): int {
            return HabboGroupJoinFailedMessageEventParser(_parser).reason;
        }
    }
}
