package com.sulake.habbo.communication.messages.incoming.collectibles {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.collectibles.class_1520

    [SecureSWF(rename="true")]
    public class SilverBalanceMessageEvent extends MessageEvent implements IMessageEvent {

        public function SilverBalanceMessageEvent(param1: Function) {
            super(param1, class_1520);
        }

        public function getParser(): class_1520 {
            return _parser as class_1520;
        }
    }
}
