package com.sulake.habbo.communication.messages.incoming.marketplace {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.marketplace.class_1350

    [SecureSWF(rename="true")]
    public class class_633 extends MessageEvent implements IMessageEvent {

        public function class_633(param1: Function) {
            super(param1, class_1350);
        }

        public function getParser(): class_1350 {
            return _parser as class_1350;
        }
    }
}
