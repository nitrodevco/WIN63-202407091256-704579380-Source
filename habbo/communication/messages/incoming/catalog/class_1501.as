package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1501 {

        public function class_1501(param1: IMessageDataWrapper) {
            var _loc2_: int = 0;
            super();
            _offerId = param1.readInteger();
            var_974 = param1.readString();
            var_1057 = param1.readBoolean();
            var_495 = param1.readInteger();
            var_525 = param1.readInteger();
            var_452 = param1.readInteger();
            var_1020 = param1.readInteger();
            var_968 = param1.readBoolean();
            var _loc3_: int = param1.readInteger();
            var_300 = new Vector.<class_1718>(0);
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                var_300.push(new class_1718(param1));
                _loc2_++;
            }
            var_842 = param1.readInteger();
            var_1420 = param1.readBoolean();
            var_1540 = param1.readBoolean();
            var_1250 = param1.readString();
        }
        private var var_974: String;

        private var var_1057: Boolean;

        private var var_495: int;

        private var var_525: int;

        private var var_1020: int;

        private var var_452: int;

        private var var_842: int;

        private var var_968: Boolean;

        private var var_1420: Boolean;

        private var var_1540: Boolean;

        private var var_1250: String;

        private var var_300: Vector.<class_1718>;

        private var _offerId: int;

        public function get offerId(): int {
            return _offerId;
        }

        public function get localizationId(): String {
            return var_974;
        }

        public function get isRent(): Boolean {
            return var_1057;
        }

        public function get priceInCredits(): int {
            return var_495;
        }

        public function get priceInActivityPoints(): int {
            return var_525;
        }

        public function get products(): Vector.<class_1718> {
            return var_300;
        }

        public function get activityPointType(): int {
            return var_452;
        }

        public function get priceInSilver(): int {
            return var_1020;
        }

        public function get clubLevel(): int {
            return var_842;
        }

        public function get giftable(): Boolean {
            return var_968;
        }

        public function get bundlePurchaseAllowed(): Boolean {
            return var_1420;
        }

        public function get previewImage(): String {
            return var_1250;
        }
    }
}
