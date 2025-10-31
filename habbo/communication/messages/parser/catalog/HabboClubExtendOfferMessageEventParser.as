package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1646

    [SecureSWF(rename="true")]
    public class HabboClubExtendOfferMessageEventParser implements IMessageParser {

        public function HabboClubExtendOfferMessageEventParser() {
            super();
        }
        private var _offer: class_1646;

        public function flush(): Boolean {
            _offer = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _offer = new class_1646(param1);
            return true;
        }

        public function offer(): class_1646 {
            return _offer;
        }
    }
}
