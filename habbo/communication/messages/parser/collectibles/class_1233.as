package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1233 implements IMessageParser {

        public function class_1233() {
            super();
        }
        private var var_411: int = 0;

        public function get transferFee(): int {
            return var_411;
        }

        public function flush(): Boolean {
            var_411 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_411 = param1.readInteger();
            return true;
        }
    }
}
