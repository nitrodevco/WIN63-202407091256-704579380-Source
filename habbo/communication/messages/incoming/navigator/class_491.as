package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1266

    [SecureSWF(rename="true")]
    public class class_491 extends MessageEvent implements IMessageEvent {

        public function class_491(param1: Function) {
            super(param1, class_1266);
        }

        public function getParser(): class_1266 {
            return this._parser as class_1266;
        }
    }
}
