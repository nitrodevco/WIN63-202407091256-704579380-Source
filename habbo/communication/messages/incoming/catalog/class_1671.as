package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    import flash.utils.getTimer

    [SecureSWF(rename="true")]
    public class class_1671 {

        public static const const_69: int = 0;

        public static const const_328: int = 1;

        public static const const_218: int = 2;

        public function class_1671(param1: IMessageDataWrapper) {
            super();
            if (!param1) {
                return;
            }
            var_810 = param1.readInteger();
            _itemName = param1.readString();
            var_1350 = param1.readString();
            var_329 = param1.readInteger();
            switch (var_329) {
                case 0:
                    var_1108 = param1.readString();
                    break;
                case 1:
                    var_1207 = param1.readInteger();
                    break;
                case 2:
                    var_394 = param1.readString();
            }
            var _loc2_: int = param1.readInteger();
            _expirationTime = _loc2_ > 0 ? _loc2_ * 1000 + getTimer() : 0;
        }
        private var var_329: int;
        private var var_810: int;
        private var var_1350: String;

        private var var_1108: String;

        private var var_394: String;

        private var var_1207: int;

        private var _expirationTime: int;

        private var _itemName: String;

        public function get itemName(): String {
            return _itemName;
        }

        public function get position(): int {
            return var_810;
        }

        public function get itemPromoImage(): String {
            return var_1350;
        }

        public function get cataloguePageLocation(): String {
            return var_1108;
        }

        public function get offerExpires(): Boolean {
            return _expirationTime > 0;
        }

        public function get secondsToExpiration(): int {
            return _expirationTime - getTimer();
        }

        public function get type(): int {
            return var_329;
        }

        public function get productCode(): String {
            return var_394;
        }

        public function get productOfferID(): int {
            return var_1207;
        }
    }
}
