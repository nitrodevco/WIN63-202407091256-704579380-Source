package com.sulake.habbo.communication.messages.incoming.inventory.bots {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.bots.class_1472

    [SecureSWF(rename="true")]
    public class class_588 extends MessageEvent implements IMessageEvent {

        public function class_588(param1: Function) {
            super(param1, class_1472);
        }

        public function getParser(): class_1472 {
            return _parser as class_1472;
        }
    }
}
