package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1621

    [SecureSWF(rename="true")]
    public class CatalogPageWithEarliestExpiryMessageEvent extends MessageEvent implements IMessageEvent {

        public function CatalogPageWithEarliestExpiryMessageEvent(param1: Function) {
            super(param1, class_1621);
        }

        public function getParser(): class_1621 {
            return this._parser as class_1621;
        }
    }
}
