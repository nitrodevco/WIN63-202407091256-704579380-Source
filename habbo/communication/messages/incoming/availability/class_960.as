package com.sulake.habbo.communication.messages.incoming.availability {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.availability.class_1248

    [SecureSWF(rename="true")]
    public class class_960 extends MessageEvent implements IMessageEvent {

        public function class_960(param1: Function) {
            super(param1, class_1248);
        }

        public function getParser(): class_1248 {
            return _parser as class_1248;
        }
    }
}
