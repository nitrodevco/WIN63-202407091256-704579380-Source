package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class GiftWrappingConfigurationEventParser implements IMessageParser {

        public function GiftWrappingConfigurationEventParser() {
            super();
        }
        private var var_1402: Boolean;
        private var var_1218: int;
        private var var_739: Array;
        private var var_754: Array;
        private var var_711: Array;
        private var var_684: Array;

        public function get isWrappingEnabled(): Boolean {
            return var_1402;
        }

        public function get wrappingPrice(): int {
            return var_1218;
        }

        public function get stuffTypes(): Array {
            return var_739;
        }

        public function get boxTypes(): Array {
            return var_754;
        }

        public function get ribbonTypes(): Array {
            return var_711;
        }

        public function get defaultStuffTypes(): Array {
            return var_684;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_739 = [];
            var_754 = [];
            var_711 = [];
            var_684 = [];
            var_1402 = param1.readBoolean();
            var_1218 = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_739.push(param1.readInteger());
                _loc3_++;
            }
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_754.push(param1.readInteger());
                _loc3_++;
            }
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_711.push(param1.readInteger());
                _loc3_++;
            }
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_684.push(param1.readInteger());
                _loc3_++;
            }
            return true;
        }
    }
}
