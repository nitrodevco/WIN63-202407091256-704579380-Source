package com.sulake.habbo.communication.messages.incoming.availability {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.availability.class_1528

    [SecureSWF(rename="true")]
    public class class_1083 extends MessageEvent implements IMessageEvent {

        public function class_1083(param1: Function) {
            super(param1, class_1528);
        }

        public function getParser(): class_1528 {
            return _parser as class_1528;
        }
    }
}
