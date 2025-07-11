package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    public class SnowWarGameTokensMessageParser implements IMessageParser {

        public function SnowWarGameTokensMessageParser() {
            super();
        }

        private var _offers: Array;

        public function get offers(): Array {
            return _offers;
        }

        public function flush(): Boolean {
            _offers = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            _offers = [];
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _offers.push(new SnowWarGameTokenOffer(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
