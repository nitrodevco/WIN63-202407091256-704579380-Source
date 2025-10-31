package com.sulake.habbo.communication.messages.parser.inventory.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class PetBreedingEventParser implements IMessageParser {

        public static const const_12: int = 1;

        public static const const_11: int = 2;

        public static const const_57: int = 3;

        public function PetBreedingEventParser() {
            super();
        }
        private var var_149: int;
        private var var_1401: int;
        private var var_879: int;

        public function get state(): int {
            return var_149;
        }

        public function get ownPetId(): int {
            return var_1401;
        }

        public function get otherPetId(): int {
            return var_879;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_149 = param1.readInteger();
            var_1401 = param1.readInteger();
            var_879 = param1.readInteger();
            return true;
        }
    }
}
