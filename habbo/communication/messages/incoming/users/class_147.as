package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1239

    [SecureSWF(rename="true")]
    public class class_147 extends MessageEvent implements IMessageEvent {

        public function class_147(param1: Function) {
            super(param1, class_1239);
        }

        public function getParser(): class_1239 {
            return _parser as class_1239;
        }
    }
}
