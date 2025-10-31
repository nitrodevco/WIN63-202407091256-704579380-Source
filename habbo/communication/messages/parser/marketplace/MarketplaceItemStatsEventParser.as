package com.sulake.habbo.communication.messages.parser.marketplace {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class MarketplaceItemStatsEventParser implements IMessageParser {

        public function MarketplaceItemStatsEventParser() {
            super();
        }
        private var var_812: int;
        private var var_1266: int;
        private var var_696: Array;

        private var var_738: Array;

        private var var_712: Array;

        private var var_1396: int;

        private var var_1175: int;

        private var _historyLength: int;

        public function get historyLength(): int {
            return _historyLength;
        }

        public function get averagePrice(): int {
            return var_812;
        }

        public function get offerCount(): int {
            return var_1266;
        }

        public function get dayOffsets(): Array {
            return var_696;
        }

        public function get averagePrices(): Array {
            return var_738;
        }

        public function get soldAmounts(): Array {
            return var_712;
        }

        public function get furniTypeId(): int {
            return var_1396;
        }

        public function get furniCategoryId(): int {
            return var_1175;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_812 = param1.readInteger();
            var_1266 = param1.readInteger();
            _historyLength = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            var_696 = [];
            var_738 = [];
            var_712 = [];
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_696.push(param1.readInteger());
                var_738.push(param1.readInteger());
                var_712.push(param1.readInteger());
                _loc3_++;
            }
            var_1175 = param1.readInteger();
            var_1396 = param1.readInteger();
            return true;
        }
    }
}
