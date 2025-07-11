package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1359

    [SecureSWF(rename="true")]
    public class class_1057 extends MessageEvent implements IMessageEvent {

        public function class_1057(param1: Function) {
            super(param1, class_1359);
        }

        public function getParser(): class_1359 {
            return this._parser as class_1359;
        }
    }
}
