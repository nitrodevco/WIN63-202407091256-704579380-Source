package com.sulake.habbo.communication.messages.parser.inventory.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ConfirmBreedingResultEventParser implements IMessageParser {

        public function ConfirmBreedingResultEventParser() {
            super();
        }
        private var var_497: int;
        private var var_152: int;

        public function get breedingNestStuffId(): int {
            return var_497;
        }

        public function get result(): int {
            return var_152;
        }

        public function flush(): Boolean {
            var_497 = 0;
            var_152 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_497 = param1.readInteger();
            var_152 = param1.readInteger();
            return true;
        }
    }
}
