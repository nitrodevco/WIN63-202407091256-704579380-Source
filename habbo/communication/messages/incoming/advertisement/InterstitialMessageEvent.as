package com.sulake.habbo.communication.messages.incoming.advertisement {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.advertisement.class_1485

    [SecureSWF(rename="true")]
    public class InterstitialMessageEvent extends MessageEvent implements IMessageEvent {

        public function InterstitialMessageEvent(param1: Function) {
            super(param1, class_1485);
        }

        public function getParser(): class_1485 {
            return this._parser as class_1485;
        }
    }
}
