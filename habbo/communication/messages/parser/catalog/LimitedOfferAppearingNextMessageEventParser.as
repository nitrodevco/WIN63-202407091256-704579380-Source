package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class LimitedOfferAppearingNextMessageEventParser implements IMessageParser {

        public function LimitedOfferAppearingNextMessageEventParser() {
            super();
        }
        private var var_422: int;
        private var var_562: int;
        private var var_398: String;

        private var _offerId: int;

        public function get offerId(): int {
            return _offerId;
        }

        public function get appearsInSeconds(): int {
            return var_422;
        }

        public function get pageId(): int {
            return var_562;
        }

        public function get productType(): String {
            return var_398;
        }

        public function flush(): Boolean {
            var_422 = -1;
            var_562 = -1;
            _offerId = -1;
            var_398 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_422 = param1.readInteger();
            var_562 = param1.readInteger();
            _offerId = param1.readInteger();
            var_398 = param1.readString();
            return true;
        }
    }
}
