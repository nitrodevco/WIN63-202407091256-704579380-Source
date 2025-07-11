package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1566

    [SecureSWF(rename="true")]
    public class class_590 extends MessageEvent implements IMessageEvent {

        public function class_590(param1: Function) {
            super(param1, class_1566);
        }

        public function getParser(): class_1566 {
            return this._parser as class_1566;
        }
    }
}
