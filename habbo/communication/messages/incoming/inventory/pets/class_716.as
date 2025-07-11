package com.sulake.habbo.communication.messages.incoming.inventory.pets {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1516

    [SecureSWF(rename="true")]
    public class class_716 extends MessageEvent implements IMessageEvent {

        public function class_716(param1: Function) {
            super(param1, class_1516);
        }

        public function getParser(): class_1516 {
            return _parser as class_1516;
        }
    }
}
