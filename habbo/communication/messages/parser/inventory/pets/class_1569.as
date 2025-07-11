package com.sulake.habbo.communication.messages.parser.inventory.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1569 implements IMessageParser {

        public function class_1569() {
            super();
        }
        private var var_545: int;
        private var var_393: int;

        public function get rarityCategory(): int {
            return var_545;
        }

        public function get petId(): int {
            return var_393;
        }

        public function flush(): Boolean {
            var_393 = -1;
            var_545 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_393 = param1.readInteger();
            var_545 = param1.readInteger();
            return true;
        }
    }
}
