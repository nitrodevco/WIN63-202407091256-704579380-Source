package com.sulake.habbo.communication.messages.parser.marketplace {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1602 implements IMessageParser {

        public function class_1602() {
            super();
        }
        private var var_1314: int;
        private var var_152: int;

        public function get tokenCount(): int {
            return var_1314;
        }

        public function get resultCode(): int {
            return var_152;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_152 = param1.readInteger();
            var_1314 = param1.readInteger();
            return true;
        }
    }
}
