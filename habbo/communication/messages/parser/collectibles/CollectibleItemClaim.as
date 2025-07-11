package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class CollectibleItemClaim {

        public static var var_1523: int = 0;

        public static var var_1609: int = 1;

        public function CollectibleItemClaim(param1: IMessageDataWrapper) {
            super();
            var_1345 = param1.readString();
            var_559 = param1.readInteger();
            var_1487 = param1.readInteger();
            _status = param1.readShort();
        }
        private var var_1345: String;
        private var var_559: int;
        private var var_1487: int;

        private var _status: int;

        public function get status(): int {
            return _status;
        }

        public function get claimId(): String {
            return var_1345;
        }

        public function get claimedAmount(): int {
            return var_559;
        }

        public function set claimedAmount(param1: int): void {
            var_559 = param1;
        }

        public function get claimLimit(): int {
            return var_1487;
        }
    }
}
