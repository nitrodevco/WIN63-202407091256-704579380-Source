package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1542

    [SecureSWF(rename="true")]
    public class class_238 extends MessageEvent implements IMessageEvent {

        public function class_238(param1: Function) {
            super(param1, class_1542);
        }

        public function get data(): class_1184 {
            return class_1542(_parser).data;
        }
    }
}
