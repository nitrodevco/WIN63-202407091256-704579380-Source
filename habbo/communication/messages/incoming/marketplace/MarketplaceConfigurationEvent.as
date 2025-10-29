package com.sulake.habbo.communication.messages.incoming.marketplace {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.marketplace.class_1445

    [SecureSWF(rename="true")]
    public class MarketplaceConfigurationEvent extends MessageEvent implements IMessageEvent {

        public function MarketplaceConfigurationEvent(param1: Function) {
            super(param1, class_1445);
        }

        public function getParser(): class_1445 {
            return _parser as class_1445;
        }
    }
}
