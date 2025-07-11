package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1123

    [SecureSWF(rename="true")]
    public class class_812 extends MessageEvent implements IMessageEvent {

        public function class_812(param1: Function) {
            super(param1, class_1123);
        }

        public function getParser(): class_1123 {
            return this._parser as class_1123;
        }
    }
}
