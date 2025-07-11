package com.sulake.habbo.communication.messages.incoming.inventory.clothing {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.clothing.class_1594

    [SecureSWF(rename="true")]
    public class class_456 extends MessageEvent implements IMessageEvent {

        public function class_456(param1: Function) {
            super(param1, class_1594);
        }

        public function getParser(): class_1594 {
            return _parser as class_1594;
        }
    }
}
