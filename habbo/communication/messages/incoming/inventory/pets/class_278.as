package com.sulake.habbo.communication.messages.incoming.inventory.pets {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1194

    [SecureSWF(rename="true")]
    public class class_278 extends MessageEvent implements IMessageEvent {

        public function class_278(param1: Function) {
            super(param1, class_1194);
        }

        public function getParser(): class_1194 {
            return _parser as class_1194;
        }
    }
}
