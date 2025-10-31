package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1501
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1643

    [SecureSWF(rename="true")]
    public class ClubGiftInfoEventParser implements IMessageParser {

        public function ClubGiftInfoEventParser() {
            super();
        }
        private var var_845: int;
        private var var_1388: int;
        private var var_151: Map;

        private var _offers: Array;

        public function get offers(): Array {
            return _offers;
        }

        public function get daysUntilNextGift(): int {
            return var_845;
        }

        public function get giftsAvailable(): int {
            return var_1388;
        }

        public function get giftData(): Map {
            return var_151;
        }

        public function flush(): Boolean {
            if (var_151) {
                var_151.dispose();
                var_151 = null;
            }
            _offers = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc4_: int = 0;
            var _loc2_: class_1643 = null;
            var_845 = param1.readInteger();
            var_1388 = param1.readInteger();
            _offers = [];
            var _loc3_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _offers.push(new class_1501(param1));
                _loc4_++;
            }
            var_151 = new Map();
            _loc3_ = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc2_ = new class_1643(param1);
                var_151.add(_loc2_.offerId, _loc2_);
                _loc4_++;
            }
            return true;
        }
    }
}
