package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1615

    [SecureSWF(rename="true")]
    public class GuildCreationInfoMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuildCreationInfoMessageEvent(param1: Function) {
            super(param1, class_1615);
        }

        public function get data(): class_1197 {
            return class_1615(_parser).data;
        }
    }
}
