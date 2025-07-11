package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1198

    [SecureSWF(rename="true")]
    public class class_315 extends MessageEvent implements IMessageEvent {

        public function class_315(param1: Function) {
            super(param1, class_1198);
        }

        public function get data(): class_1251 {
            return class_1198(_parser).data;
        }

        public function get guildId(): int {
            return class_1198(_parser).guildId;
        }
    }
}
