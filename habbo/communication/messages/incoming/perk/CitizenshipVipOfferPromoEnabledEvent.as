package com.sulake.habbo.communication.messages.incoming.perk {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.perk.class_1538

    [SecureSWF(rename="true")]
    public class CitizenshipVipOfferPromoEnabledEvent extends MessageEvent implements IMessageEvent {

        public function CitizenshipVipOfferPromoEnabledEvent(param1: Function) {
            super(param1, class_1538);
        }

        public function getParser(): class_1538 {
            return _parser as class_1538;
        }
    }
}
