package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1318

    [SecureSWF(rename="true")]
    public class GuildMembershipRejectedMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuildMembershipRejectedMessageEvent(param1: Function) {
            super(param1, class_1318);
        }

        public function getParser(): class_1318 {
            return class_1318(_parser);
        }
    }
}
