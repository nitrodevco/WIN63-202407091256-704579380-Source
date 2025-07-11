package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1340 implements IMessageParser {

        public function class_1340() {
            super();
        }
        private var var_1434: Boolean;

        private var _offerId: int;

        public function get offerId(): int {
            return _offerId;
        }

        public function get isGiftable(): Boolean {
            return var_1434;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _offerId = param1.readInteger();
            var_1434 = param1.readBoolean();
            return true;
        }
    }
}
