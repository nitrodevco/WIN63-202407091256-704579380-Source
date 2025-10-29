package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1161

    [SecureSWF(rename="true")]
    public class CatalogPublishedMessageEvent extends MessageEvent implements IMessageEvent {

        public function CatalogPublishedMessageEvent(param1: Function) {
            super(param1, class_1161);
        }

        public function get instantlyRefreshCatalogue(): Boolean {
            return getParser().instantlyRefreshCatalogue;
        }

        public function get newFurniDataHash(): String {
            return getParser().newFurniDataHash;
        }

        public function getParser(): class_1161 {
            return this._parser as class_1161;
        }
    }
}
