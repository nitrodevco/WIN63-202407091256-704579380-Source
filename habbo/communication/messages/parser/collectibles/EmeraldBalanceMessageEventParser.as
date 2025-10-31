package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class EmeraldBalanceMessageEventParser implements IMessageParser {

        public function EmeraldBalanceMessageEventParser() {
            super();
        }
        private var var_478: int = 0;

        public function get emeraldBalance(): int {
            return var_478;
        }

        public function flush(): Boolean {
            var_478 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_478 = param1.readInteger();
            return true;
        }
    }
}
