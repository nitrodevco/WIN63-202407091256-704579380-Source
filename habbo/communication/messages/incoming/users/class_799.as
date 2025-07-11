package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1564

    [SecureSWF(rename="true")]
    public class class_799 extends MessageEvent implements IMessageEvent {

        public function class_799(param1: Function) {
            super(param1, class_1564);
        }

        public function get userId(): int {
            return (_parser as class_1564).userId;
        }

        public function get respectTotal(): int {
            return (_parser as class_1564).respectTotal;
        }
    }
}
