package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1416 implements IMessageParser {

        public function class_1416() {
            super();
        }
        private var var_398: String;
        private var var_389: int;
        private var var_522: int;

        private var _totalCoinsForBonus: int;

        public function get totalCoinsForBonus(): int {
            return _totalCoinsForBonus;
        }

        public function get coinsStillRequiredToBuy(): int {
            return var_522;
        }

        public function get productType(): String {
            return var_398;
        }

        public function get productClassId(): int {
            return var_389;
        }

        public function flush(): Boolean {
            _totalCoinsForBonus = -1;
            var_522 = -1;
            var_398 = "";
            var_389 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_398 = param1.readString();
            var_389 = param1.readInteger();
            _totalCoinsForBonus = param1.readInteger();
            var_522 = param1.readInteger();
            return true;
        }
    }
}
