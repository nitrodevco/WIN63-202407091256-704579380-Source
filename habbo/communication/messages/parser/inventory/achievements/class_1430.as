package com.sulake.habbo.communication.messages.parser.inventory.achievements {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1430 implements IMessageParser {

        public function class_1430() {
            super();
        }
        private var var_367: int;

        public function get score(): int {
            return var_367;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_367 = param1.readInteger();
            return true;
        }
    }
}
