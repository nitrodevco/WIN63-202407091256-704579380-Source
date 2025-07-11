package com.sulake.habbo.communication.messages.incoming.gifts {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.gifts.class_1426

    [SecureSWF(rename="true")]
    public class class_785 extends MessageEvent implements IMessageEvent {

        public function class_785(param1: Function) {
            super(param1, class_1426);
        }

        public function getParser(): class_1426 {
            return _parser as class_1426;
        }
    }
}
