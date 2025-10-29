package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1367

    [SecureSWF(rename="true")]
    public class CatalogIndexMessageEvent extends MessageEvent implements IMessageEvent {

        public function CatalogIndexMessageEvent(param1: Function) {
            super(param1, class_1367);
        }

        public function get root(): class_1373 {
            return getParser().root;
        }

        public function get newAdditionsAvailable(): Boolean {
            return getParser().newAdditionsAvailable;
        }

        public function get catalogType(): String {
            return getParser().catalogType;
        }

        public function getParser(): class_1367 {
            return this._parser as class_1367;
        }
    }
}
