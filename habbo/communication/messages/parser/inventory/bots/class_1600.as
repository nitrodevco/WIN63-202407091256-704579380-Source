package com.sulake.habbo.communication.messages.parser.inventory.bots {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1600 implements IMessageParser {

        public function class_1600() {
            super();
        }
        private var var_928: Boolean;
        private var var_325: class_1726;

        public function get boughtAsGift(): Boolean {
            return var_928;
        }

        public function get item(): class_1726 {
            return var_325;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_928 = param1.readBoolean();
            var_325 = new class_1726(param1);
            return true;
        }
    }
}
