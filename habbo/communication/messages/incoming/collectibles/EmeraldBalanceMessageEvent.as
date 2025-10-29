package com.sulake.habbo.communication.messages.incoming.collectibles {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.collectibles.class_1502

    [SecureSWF(rename="true")]
    public class EmeraldBalanceMessageEvent extends MessageEvent implements IMessageEvent {

        public function EmeraldBalanceMessageEvent(param1: Function) {
            super(param1, class_1502);
        }

        public function getParser(): class_1502 {
            return _parser as class_1502;
        }
    }
}
