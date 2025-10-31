package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class NftCollectionsMessageEventParser implements IMessageParser {

        public function NftCollectionsMessageEventParser() {
            super();
        }
        private var var_292: Array;

        public function get nftCollections(): Array {
            return var_292;
        }

        public function flush(): Boolean {
            var_292 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_292 = [];
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_292.push(new class_1692(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
