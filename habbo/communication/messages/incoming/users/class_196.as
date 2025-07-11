package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1131

    [SecureSWF(rename="true")]
    public class class_196 extends MessageEvent implements IMessageEvent {

        public function class_196(param1: Function) {
            super(param1, class_1131);
        }

        public function get giverUserId(): int {
            return class_1131(_parser).giverUserId;
        }

        public function get handItemType(): int {
            return class_1131(_parser).handItemType;
        }
    }
}
