package com.sulake.habbo.communication.messages.parser.inventory.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1516 implements IMessageParser {

        public function class_1516() {
            super();
        }
        private var var_393: int;

        public function get petId(): int {
            return var_393;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_393 = param1.readInteger();
            return true;
        }
    }
}
