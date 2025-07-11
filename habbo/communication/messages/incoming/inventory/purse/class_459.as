package com.sulake.habbo.communication.messages.incoming.inventory.purse {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.purse.class_1192

    [SecureSWF(rename="true")]
    public class class_459 extends MessageEvent implements IMessageEvent {

        public function class_459(param1: Function) {
            super(param1, class_1192);
        }

        public function getParser(): class_1192 {
            return this._parser as class_1192;
        }
    }
}
