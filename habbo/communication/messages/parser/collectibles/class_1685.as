package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1685 {

        public function class_1685(param1: IMessageDataWrapper) {
            super();
            _offerId = param1.readInteger();
            var_394 = param1.readString();
            var_1368 = param1.readInteger();
            var_1143 = param1.readInteger();
        }
        private var var_394: String;

        private var var_1368: int;

        private var var_1143: int;

        private var _offerId: int;

        public function get offerId(): int {
            return _offerId;
        }

        public function get productCode(): String {
            return var_394;
        }

        public function get silverPrice(): int {
            return var_1368;
        }

        public function get amountTokens(): int {
            return var_1143;
        }
    }
}
