package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1431

    [SecureSWF(rename="true")]
    public class class_543 extends MessageEvent implements IMessageEvent {

        public function class_543(param1: Function) {
            super(param1, class_1431);
        }

        public function get result(): int {
            return (_parser as class_1431).result;
        }

        public function get userId(): int {
            return (_parser as class_1431).ignoredUserId;
        }
    }
}
