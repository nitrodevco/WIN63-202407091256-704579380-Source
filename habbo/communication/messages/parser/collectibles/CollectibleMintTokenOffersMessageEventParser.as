package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CollectibleMintTokenOffersMessageEventParser implements IMessageParser {

        public function CollectibleMintTokenOffersMessageEventParser() {
            super();
        }

        private var _tokenOffers: Vector.<class_1685>;

        public function get tokenOffers(): Vector.<class_1685> {
            return _tokenOffers;
        }

        public function flush(): Boolean {
            _tokenOffers = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc4_: int = 0;
            var _loc2_: class_1685 = null;
            _tokenOffers = new Vector.<class_1685>();
            var _loc3_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc2_ = new class_1685(param1);
                _tokenOffers.push(_loc2_);
                _loc4_++;
            }
            return true;
        }
    }
}
