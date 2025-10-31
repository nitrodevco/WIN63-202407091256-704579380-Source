package com.sulake.habbo.communication.messages.parser.marketplace {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.marketplace.class_1699
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1642
    import com.sulake.habbo.room.IStuffData
    import com.sulake.habbo.room.object.data.class_1697

    [SecureSWF(rename="true")]
    public class MarketPlaceOffersEventParser implements IMessageParser {

        public static const const_366: int = 1;

        public static const const_67: int = 2;

        public static const const_134: int = 3;

        private const const_66: int = 500;

        public function MarketPlaceOffersEventParser() {
            super();
        }
        private var var_1028: int;

        private var _offers: Array;

        public function get offers(): Array {
            return _offers;
        }

        public function get totalItemsFound(): int {
            return var_1028;
        }

        public function flush(): Boolean {
            _offers = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc12_: int = 0;
            var _loc14_: int = 0;
            var _loc2_: int = 0;
            var _loc4_: int = 0;
            var _loc11_: int = 0;
            var _loc8_: int = 0;
            var _loc13_: int = 0;
            var _loc6_: int = 0;
            var _loc7_: int = 0;
            var _loc3_: class_1699 = null;
            _offers = [];
            var _loc5_: String = "";
            var _loc10_: IStuffData = null;
            var _loc9_: int = param1.readInteger();
            _loc7_ = 0;
            while (_loc7_ < _loc9_) {
                _loc10_ = null;
                _loc12_ = param1.readInteger();
                _loc14_ = param1.readInteger();
                _loc2_ = param1.readInteger();
                if (_loc2_ == 1) {
                    _loc4_ = param1.readInteger();
                    _loc10_ = class_1642.parseStuffData(param1);
                } else if (_loc2_ == 2) {
                    _loc4_ = param1.readInteger();
                    _loc5_ = param1.readString();
                } else if (_loc2_ == 3) {
                    _loc4_ = param1.readInteger();
                    (_loc10_ = class_1697.getStuffDataWrapperForType(0)).uniqueSerialNumber = param1.readInteger();
                    _loc10_.uniqueSeriesSize = param1.readInteger();
                    _loc2_ = 1;
                }
                _loc11_ = param1.readInteger();
                _loc8_ = param1.readInteger();
                _loc13_ = param1.readInteger();
                _loc6_ = param1.readInteger();
                _loc3_ = new class_1699(_loc12_, _loc4_, _loc2_, _loc5_, _loc10_, _loc11_, _loc14_, _loc8_, _loc13_, _loc6_);
                if (_loc7_ < 500) {
                    _offers.push(_loc3_);
                }
                _loc7_++;
            }
            var_1028 = param1.readInteger();
            return true;
        }
    }
}
