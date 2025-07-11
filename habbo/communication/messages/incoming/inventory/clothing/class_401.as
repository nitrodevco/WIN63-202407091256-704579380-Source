package com.sulake.habbo.communication.messages.incoming.inventory.clothing {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.clothing.class_1487

    [SecureSWF(rename="true")]
    public class class_401 extends MessageEvent implements IMessageEvent {

        public function class_401(param1: Function) {
            super(param1, class_1487);
        }

        public function getParser(): class_1487 {
            return _parser as class_1487;
        }
    }
}
