package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1406

    [SecureSWF(rename="true")]
    public class class_132 extends MessageEvent implements IMessageEvent {

        public function class_132(param1: Function) {
            super(param1, class_1406);
        }

        public function get userId(): int {
            return class_1406(_parser).userId;
        }
    }
}
