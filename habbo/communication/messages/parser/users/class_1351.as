package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1351 implements IMessageParser {

        public static const const_68: int = 0;

        public function class_1351() {
            super();
        }
        private var var_152: int;

        public function get result(): int {
            return var_152;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_152 = param1.readInteger();
            return true;
        }
    }
}
