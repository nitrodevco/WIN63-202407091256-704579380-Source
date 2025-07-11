package com.sulake.habbo.communication.messages.incoming.mysterybox {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.mysterybox.class_1362

    [SecureSWF(rename="true")]
    public class class_601 extends MessageEvent implements IMessageEvent {

        public function class_601(param1: Function) {
            super(param1, class_1362);
        }

        public function getParser(): class_1362 {
            return _parser as class_1362;
        }
    }
}
