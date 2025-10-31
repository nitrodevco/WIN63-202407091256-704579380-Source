package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1501
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1651
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1671

    [SecureSWF(rename="true")]
    public class CatalogPageMessageEventParser implements IMessageParser {

        public function CatalogPageMessageEventParser() {
            super();
        }
        private var var_562: int;
        private var var_395: String;
        private var var_529: String;
        private var var_433: Boolean;

        private var _localization: class_1651;

        public function get localization(): class_1651 {
            return _localization;
        }

        private var _offers: Vector.<class_1501>;

        public function get offers(): Vector.<class_1501> {
            return _offers;
        }

        private var _offerId: int;

        public function get offerId(): int {
            return _offerId;
        }

        private var _frontPageItems: Vector.<class_1671>;

        public function get frontPageItems(): Vector.<class_1671> {
            return _frontPageItems;
        }

        public function get pageId(): int {
            return var_562;
        }

        public function get catalogType(): String {
            return var_395;
        }

        public function get layoutCode(): String {
            return var_529;
        }

        public function get acceptSeasonCurrencyAsCredits(): Boolean {
            return var_433;
        }

        public function flush(): Boolean {
            var_562 = -1;
            var_395 = "";
            var_529 = "";
            _localization = null;
            _offers = new Vector.<class_1501>(0);
            _offerId = -1;
            var_433 = false;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_562 = param1.readInteger(); //PageId
            var_395 = param1.readString(); //CatalogType
            var_529 = param1.readString(); //LayoutCode

            _localization = new class_1651(param1);

            _offers = new Vector.<class_1501>(0);
        
            var _loc2_: int = param1.readInteger(); //Offers Count
            _loc3_ = 0;

            while (_loc3_ < _loc2_) {
                _offers.push(new class_1501(param1)); //Serialize Offer
                _loc3_++;
            }

            _offerId = param1.readInteger(); //Offer Id
            var_433 = param1.readBoolean(); //AcceptSeasonCurrencyAsCredits

            if (param1.bytesAvailable) {
                _frontPageItems = new Vector.<class_1671>(0);
                _loc2_ = param1.readInteger(); //FrontpageItems Count
                _loc3_ = 0;
                while (_loc3_ < _loc2_) {
                    _frontPageItems.push(new class_1671(param1)); //Serialize FrontPageItem
                    _loc3_++;
                }
            }
            return true;
        }
    }
}
