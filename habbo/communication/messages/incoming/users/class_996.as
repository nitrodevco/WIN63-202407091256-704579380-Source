package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1160

    [SecureSWF(rename="true")]
    public class class_996 extends MessageEvent implements IMessageEvent {

        public function class_996(param1: Function) {
            super(param1, class_1160);
        }

        public function get data(): class_1581 {
            return class_1160(_parser).data;
        }
    }
}
