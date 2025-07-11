package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1388

    [SecureSWF(rename="true")]
    public class class_467 extends MessageEvent implements IMessageEvent {

        public function class_467(param1: Function) {
            super(param1, class_1388);
        }

        public function getParser(): class_1388 {
            return this._parser as class_1388;
        }
    }
}
