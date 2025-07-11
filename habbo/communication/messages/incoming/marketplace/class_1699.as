package com.sulake.habbo.communication.messages.incoming.marketplace {
    import com.sulake.habbo.room.IStuffData

    [SecureSWF(rename="true")]
    public class class_1699 {

        public function class_1699(param1: int, param2: int, param3: int, param4: String, param5: IStuffData, param6: int, param7: int, param8: int, param9: int, param10: int = -1) {
            super();
            _offerId = param1;
            var_603 = param2;
            var_813 = param3;
            var_1364 = param4;
            var_1091 = param5;
            var_886 = param6;
            _status = param7;
            var_1221 = param8;
            var_812 = param9;
            _offerCount = param10;
        }
        private var var_603: int;

        private var var_813: int;

        private var var_1364: String;

        private var var_1091: IStuffData;

        private var var_886: int;
        private var var_1221: int = -1;
        private var var_812: int;

        private var _offerId: int;

        public function get offerId(): int {
            return _offerId;
        }

        private var _status: int;

        public function get status(): int {
            return _status;
        }

        private var _offerCount: int;

        public function get offerCount(): int {
            return _offerCount;
        }

        public function get furniId(): int {
            return var_603;
        }

        public function get furniType(): int {
            return var_813;
        }

        public function get extraData(): String {
            return var_1364;
        }

        public function get stuffData(): IStuffData {
            return var_1091;
        }

        public function get price(): int {
            return var_886;
        }

        public function get timeLeftMinutes(): int {
            return var_1221;
        }

        public function get averagePrice(): int {
            return var_812;
        }
    }
}
