package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1126

    [SecureSWF(rename="true")]
    public class NotEnoughBalanceMessageEvent extends MessageEvent implements IMessageEvent {

        public function NotEnoughBalanceMessageEvent(param1: Function) {
            super(param1, class_1126);
        }

        public function getParser(): class_1126 {
            return this._parser as class_1126;
        }
    }
}
