package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class SilverBalanceMessageEventParser implements IMessageParser {

        public function SilverBalanceMessageEventParser() {
            super();
        }
        private var var_630: int = 0;

        public function get silverBalance(): int {
            return var_630;
        }

        public function flush(): Boolean {
            var_630 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_630 = param1.readInteger();
            return true;
        }
    }
}
