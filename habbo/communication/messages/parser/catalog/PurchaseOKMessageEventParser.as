package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1669

    [SecureSWF(rename="true")]
    public class PurchaseOKMessageEventParser implements IMessageParser {

        public function PurchaseOKMessageEventParser() {
            super();
        }

        private var _offer: class_1669;

        public function get offer(): class_1669 {
            return _offer;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _offer = new class_1669(param1);
            return true;
        }
    }
}
