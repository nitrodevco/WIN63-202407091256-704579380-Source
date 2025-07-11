package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1483 implements IMessageParser {

        public static const const_369: int = 0;

        public static const const_405: int = 1;

        public function class_1483() {
            super();
        }
        private var var_296: int;
        private var var_1572: int;

        public function get resultCode(): int {
            return var_296;
        }

        public function get roomLimit(): int {
            return var_1572;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this.var_296 = param1.readInteger();
            this.var_1572 = param1.readInteger();
            return true;
        }
    }
}
