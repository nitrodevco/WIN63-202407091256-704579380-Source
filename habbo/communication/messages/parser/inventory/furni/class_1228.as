package com.sulake.habbo.communication.messages.parser.inventory.furni {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1228 implements IMessageParser {

        public function class_1228() {
            super();
        }
        private var var_280: int;
        private var var_1465: int;

        public function get id(): int {
            return var_280;
        }

        public function get itemsLeft(): int {
            return var_1465;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_280 = param1.readInteger();
            var_1465 = param1.readInteger();
            return true;
        }

        public function flush(): Boolean {
            return true;
        }
    }
}
