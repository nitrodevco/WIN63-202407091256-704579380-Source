package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1605

    [SecureSWF(rename="true")]
    public class GuildCreatedMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuildCreatedMessageEvent(param1: Function) {
            super(param1, class_1605);
        }

        public function get baseRoomId(): int {
            return class_1605(_parser).baseRoomId;
        }

        public function get groupId(): int {
            return class_1605(_parser).groupId;
        }
    }
}
