package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1210

    [SecureSWF(rename="true")]
    public class class_232 extends MessageEvent implements IMessageEvent {

        public function class_232(param1: Function) {
            super(param1, class_1210);
        }

        public function get reason(): int {
            return class_1210(_parser).reason;
        }
    }
}
