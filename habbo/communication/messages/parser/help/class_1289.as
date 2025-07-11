package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1289 implements IMessageParser {

        public static const const_384: int = 0;

        public static const const_198: int = 1;

        public static const const_181: int = 2;

        public static const const_17: int = 3;

        public static const const_174: int = 4;

        public function class_1289() {
            super();
        }
        private var var_412: int;

        public function get errorCode(): int {
            return var_412;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_412 = param1.readInteger();
            return true;
        }
    }
}
