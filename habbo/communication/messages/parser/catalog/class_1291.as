package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1291 implements IMessageParser {

        public function class_1291() {
            super();
        }
        private var var_412: int = 0;

        public function get errorCode(): int {
            return var_412;
        }

        public function flush(): Boolean {
            var_412 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_412 = param1.readInteger();
            return true;
        }
    }
}
