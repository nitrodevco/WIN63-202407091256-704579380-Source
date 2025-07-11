package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1186

    [SecureSWF(rename="true")]
    public class class_668 extends MessageEvent implements IMessageEvent {

        public function class_668(param1: Function) {
            super(param1, class_1186);
        }

        public function get reason(): int {
            return class_1186(_parser).reason;
        }

        public function get guildId(): int {
            return class_1186(_parser).guildId;
        }
    }
}
