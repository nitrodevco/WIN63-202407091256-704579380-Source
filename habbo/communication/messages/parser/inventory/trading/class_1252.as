package com.sulake.habbo.communication.messages.parser.inventory.trading {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1252 implements IMessageParser {

        public function class_1252() {
            super();
        }
        private var var_440: int;

        public function get silverFee(): int {
            return var_440;
        }

        public function flush(): Boolean {
            var_440 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_440 = param1.readInteger();
            return true;
        }
    }
}
