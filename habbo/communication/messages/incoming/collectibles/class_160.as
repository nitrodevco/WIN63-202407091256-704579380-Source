package com.sulake.habbo.communication.messages.incoming.collectibles {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.collectibles.class_1141

    [SecureSWF(rename="true")]
    public class class_160 extends MessageEvent implements IMessageEvent {

        public function class_160(param1: Function) {
            super(param1, class_1141);
        }

        public function getParser(): class_1141 {
            return _parser as class_1141;
        }
    }
}
