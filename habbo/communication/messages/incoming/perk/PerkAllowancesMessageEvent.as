package com.sulake.habbo.communication.messages.incoming.perk {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.perk.class_1448

    [SecureSWF(rename="true")]
    public class PerkAllowancesMessageEvent extends MessageEvent implements IMessageEvent {

        public function PerkAllowancesMessageEvent(param1: Function) {
            super(param1, class_1448);
        }

        public function getParser(): class_1448 {
            return _parser as class_1448;
        }
    }
}
