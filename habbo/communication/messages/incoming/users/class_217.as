package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1585

    [SecureSWF(rename="true")]
    public class class_217 extends MessageEvent implements IMessageEvent {

        public function class_217(param1: Function) {
            super(param1, class_1585);
        }

        public function getParser(): class_1585 {
            return _parser as class_1585;
        }
    }
}
