package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1205

    [SecureSWF(rename="true")]
    public class class_246 extends MessageEvent implements IMessageEvent {

        public function class_246(param1: Function) {
            super(param1, class_1205);
        }

        public function get groupId(): int {
            return class_1205(_parser).groupId;
        }
    }
}
