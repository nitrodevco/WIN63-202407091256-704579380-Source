package com.sulake.habbo.communication.messages.parser.inventory.bots {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1447 implements IMessageParser {

        public function class_1447() {
            super();
        }
        private var var_325: class_1726;
        private var var_948: Boolean;

        public function get item(): class_1726 {
            return var_325;
        }

        public function flush(): Boolean {
            var_325 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_325 = new class_1726(param1);
            var_948 = param1.readBoolean();
            return true;
        }

        public function openInventory(): Boolean {
            return var_948;
        }
    }
}
