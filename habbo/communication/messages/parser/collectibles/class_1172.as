package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1172 implements IMessageParser {

        public static var var_1619: int = 0;

        public static var var_1612: int = 1;

        public static var var_1622: int = 2;

        public function class_1172() {
            super();
        }
        private var var_518: int;

        public function get mintResult(): int {
            return var_518;
        }

        public function flush(): Boolean {
            var_518 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_518 = param1.readShort();
            return true;
        }
    }
}
