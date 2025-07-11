package com.sulake.habbo.communication.messages.parser.inventory.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1438 implements IMessageParser {

        public function class_1438() {
            super();
        }
        private var var_928: Boolean;
        private var var_462: class_1679;

        public function get boughtAsGift(): Boolean {
            return var_928;
        }

        public function get pet(): class_1679 {
            return var_462;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_928 = param1.readBoolean();
            var_462 = new class_1679(param1);
            return true;
        }
    }
}
