package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1372

    [SecureSWF(rename="true")]
    public class class_975 extends MessageEvent implements IMessageEvent {

        public function class_975(param1: Function) {
            super(param1, class_1372);
        }

        public function getParser(): class_1372 {
            return this._parser as class_1372;
        }
    }
}
