package com.sulake.habbo.communication.messages.parser.inventory.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class PetAddedToInventoryEventParser implements IMessageParser {

        public function PetAddedToInventoryEventParser() {
            super();
        }
        private var var_462: class_1679;
        private var var_948: Boolean;

        public function get pet(): class_1679 {
            return var_462;
        }

        public function flush(): Boolean {
            var_462 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_462 = new class_1679(param1);
            var_948 = param1.readBoolean();
            return true;
        }

        public function openInventory(): Boolean {
            return var_948;
        }
    }
}
