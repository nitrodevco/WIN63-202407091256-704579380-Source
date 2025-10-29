package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1614

    [SecureSWF(rename="true")]
    public class GuildMembersMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuildMembersMessageEvent(param1: Function) {
            super(param1, class_1614);
        }

        public function get data(): class_1212 {
            return class_1614(_parser).data;
        }
    }
}
