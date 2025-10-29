package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1477

    [SecureSWF(rename="true")]
    public class LimitedEditionSoldOutEvent extends MessageEvent implements IMessageEvent {

        public function LimitedEditionSoldOutEvent(param1: Function) {
            super(param1, class_1477);
        }

        public function getParser(): class_1477 {
            return this._parser as class_1477;
        }
    }
}
