package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1179

    [SecureSWF(rename="true")]
    public class class_835 extends MessageEvent implements IMessageEvent {

        public function class_835(param1: Function) {
            super(param1, class_1179);
        }

        public function get data(): class_1199 {
            return class_1179(_parser).data;
        }
    }
}
