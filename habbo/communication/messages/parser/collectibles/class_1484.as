package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1484 implements IMessageParser {

        public function class_1484() {
            super();
        }
        private var var_367: int;
        private var var_1160: int;
        private var var_360: int;

        public function get score(): int {
            return var_367;
        }

        public function get highestScore(): int {
            return var_1160;
        }

        public function get level(): int {
            return var_360;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_367 = param1.readInteger();
            var_1160 = param1.readInteger();
            var_360 = param1.readInteger();
            return true;
        }
    }
}
