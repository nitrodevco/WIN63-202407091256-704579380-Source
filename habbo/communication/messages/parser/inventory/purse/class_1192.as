package com.sulake.habbo.communication.messages.parser.inventory.purse {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1192 implements IMessageParser {

        public function class_1192() {
            super();
        }
        private var var_1417: int;

        public function get balance(): int {
            return var_1417;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1417 = int(param1.readString());
            return true;
        }

        public function flush(): Boolean {
            return true;
        }
    }
}
