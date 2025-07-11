package com.sulake.habbo.communication.messages.incoming.mysterybox {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.mysterybox.class_1283

    [SecureSWF(rename="true")]
    public class class_695 extends MessageEvent implements IMessageEvent {

        public function class_695(param1: Function) {
            super(param1, class_1283);
        }

        public function getParser(): class_1283 {
            return _parser as class_1283;
        }
    }
}
