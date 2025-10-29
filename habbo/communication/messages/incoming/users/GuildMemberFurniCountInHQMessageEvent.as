package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1242

    [SecureSWF(rename="true")]
    public class GuildMemberFurniCountInHQMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuildMemberFurniCountInHQMessageEvent(param1: Function) {
            super(param1, class_1242);
        }

        public function userId(): int {
            return class_1242(_parser).userId;
        }

        public function furniCount(): int {
            return class_1242(_parser).furniCount;
        }
    }
}
