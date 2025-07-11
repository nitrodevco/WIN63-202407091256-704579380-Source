package com.sulake.habbo.communication.messages.parser.inventory.achievements {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_1724

    [SecureSWF(rename="true")]
    public class class_1433 implements IMessageParser {

        public function class_1433() {
            super();
        }
        private var var_419: class_1724;

        public function get achievement(): class_1724 {
            return var_419;
        }

        public function flush(): Boolean {
            var_419 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_419 = new class_1724(param1);
            return true;
        }
    }
}
