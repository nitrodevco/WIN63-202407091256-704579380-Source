package com.sulake.habbo.communication.messages.incoming.inventory.bots {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.bots.class_1600

    [SecureSWF(rename="true")]
    public class class_258 extends MessageEvent implements IMessageEvent {

        public function class_258(param1: Function) {
            super(param1, class_1600);
        }

        public function getParser(): class_1600 {
            return _parser as class_1600;
        }
    }
}
