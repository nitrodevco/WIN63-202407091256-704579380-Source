package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class RentableSpaceStatusMessageEventParser implements IMessageParser {

        public function RentableSpaceStatusMessageEventParser() {
            super();
        }
        private var var_655: Boolean;
        private var var_375: int;
        private var var_420: String;
        private var var_947: Boolean;
        private var var_733: int;
        private var var_1016: int;
        private var var_886: int;

        public function get rented(): Boolean {
            return var_655;
        }

        public function get renterId(): int {
            return var_375;
        }

        public function get renterName(): String {
            return var_420;
        }

        public function get canRent(): Boolean {
            return var_947;
        }

        public function get price(): int {
            return var_886;
        }

        public function get timeRemaining(): int {
            return var_1016;
        }

        public function get canRentErrorCode(): int {
            return var_733;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_655 = param1.readBoolean();
            var_733 = param1.readInteger();
            var_947 = var_733 === 0;
            var_375 = param1.readInteger();
            var_420 = param1.readString();
            var_1016 = param1.readInteger();
            var_886 = param1.readInteger();
            if (!var_655) {
                var_375 = -1;
                var_420 = "";
            }
            return true;
        }
    }
}
