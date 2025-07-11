package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    import flash.utils.getTimer

    [SecureSWF(rename="true")]
    public class class_1725 {

        public function class_1725(param1: class_1725 = null) {
            super();
            if (param1 != null) {
                var_280 = param1.id;
                var_443 = param1.identifier;
                var_329 = param1.type;
                var_617 = param1.title;
                var_363 = param1.description;
                var_406 = param1.imageUrl;
                var_499 = param1.iconImageUrl;
                var_394 = param1.productCode;
                var_168 = param1.purchaseLimit;
                _expirationTime = param1.expirationTime;
                var_495 = param1.priceInCredits;
                var_525 = param1.priceInActivityPoints;
                var_452 = param1.activityPointType;
                var_297 = param1.subProductCodes;
                var_577 = param1.trackingState;
            }
        }
        protected var var_280: int;
        protected var var_443: String;
        protected var var_329: int;
        protected var var_617: String;
        protected var var_363: String;
        protected var var_406: String;
        protected var var_499: String;
        protected var var_394: String;
        protected var var_168: int;
        protected var var_495: int;

        protected var var_525: int;

        protected var var_452: int;

        protected var var_297: Vector.<String>;

        protected var var_577: int;

        protected var _expirationTime: uint;

        public function get expirationTime(): int {
            return _expirationTime;
        }

        public function get id(): int {
            return var_280;
        }

        public function get identifier(): String {
            return var_443;
        }

        public function get type(): int {
            return var_329;
        }

        public function get title(): String {
            return var_617;
        }

        public function get description(): String {
            return var_363;
        }

        public function get imageUrl(): String {
            return var_406;
        }

        public function get iconImageUrl(): String {
            return var_499;
        }

        public function get productCode(): String {
            return var_394;
        }

        public function get purchaseLimit(): int {
            return var_168;
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

        public function get subProductCodes(): Vector.<String> {
            return var_297;
        }

        public function get trackingState(): int {
            return var_577;
        }

        public function parse(param1: IMessageDataWrapper): class_1725 {
            var _loc3_: int = 0;
            var_577 = param1.readInteger();
            var_280 = param1.readInteger();
            var_443 = param1.readString();
            var_394 = param1.readString();
            var_495 = param1.readInteger();
            var_525 = param1.readInteger();
            var_452 = param1.readInteger();
            var_168 = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            _expirationTime = _loc2_ > 0 ? _loc2_ * 1000 + getTimer() : 0;
            var_617 = param1.readString();
            var_363 = param1.readString();
            var_406 = param1.readString();
            var_499 = param1.readString();
            var_329 = param1.readInteger();
            var_297 = new Vector.<String>(0);
            var _loc4_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc4_) {
                var_297.push(param1.readString());
                _loc3_++;
            }
            return this;
        }

        public function purchased(param1: int): void {
            var_168 -= param1;
        }
    }
}
