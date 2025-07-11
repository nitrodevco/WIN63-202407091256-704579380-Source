package com.sulake.habbo.communication.messages.parser.inventory.clothing {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1594 implements IMessageParser {

        public function class_1594() {
            super();
        }
        private var var_517: int;

        public function get itemId(): int {
            return var_517;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_517 = param1.readInteger();
            return true;
        }
    }
}
