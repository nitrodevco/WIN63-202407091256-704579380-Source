package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class SnowWarGameTokenOffer {

        public function SnowWarGameTokenOffer(param1: IMessageDataWrapper) {
            super();
            _offerId = param1.readInteger();
            var_974 = param1.readString();
            var_495 = param1.readInteger();
            var_525 = param1.readInteger();
            var_452 = param1.readInteger();
            var_968 = false;
        }
        private var var_974: String;

        private var var_495: int;

        private var var_525: int;

        private var var_452: int;

        private var var_842: int;

        private var var_968: Boolean;

        private var _offerId: int;

        public function get offerId(): int {
            return _offerId;
        }

        public function get localizationId(): String {
            return var_974;
        }

        public function get priceInCredits(): int {
            return var_495;
        }

        public function get priceInActivityPoints(): int {
            return var_525;
        }

        public function get activityPointType(): int {
            return var_452;
        }

        public function get clubLevel(): int {
            return var_842;
        }

        public function get giftable(): Boolean {
            return var_968;
        }
    }
}
