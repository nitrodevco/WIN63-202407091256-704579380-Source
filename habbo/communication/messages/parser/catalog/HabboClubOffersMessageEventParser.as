package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1645

    [SecureSWF(rename="true")]
    public class HabboClubOffersMessageEventParser implements IMessageParser {

        public function HabboClubOffersMessageEventParser() {
            super();
        }
        private var var_1099: int;

        private var _offers: Array;

        public function get offers(): Array {
            return _offers;
        }

        public function get source(): int {
            return var_1099;
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
                _offers.push(new class_1645(param1));
                _loc3_++;
            }
            var_1099 = param1.readInteger();
            return true;
        }
    }
}
