package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1234

    [SecureSWF(rename="true")]
    public class GuildMembershipsMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuildMembershipsMessageEvent(param1: Function) {
            super(param1, class_1234);
        }

        public function get guilds(): Array {
            return class_1234(_parser).guilds;
        }
    }
}
