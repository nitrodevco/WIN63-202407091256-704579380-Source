package com.sulake.habbo.communication.messages.parser.inventory.trading {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1504 implements IMessageParser {

        public function class_1504() {
            super();
        }
        private var var_476: int;
        private var var_539: Boolean;

        public function get userID(): int {
            return var_476;
        }

        public function get userAccepts(): Boolean {
            return var_539;
        }

        public function flush(): Boolean {
            var_476 = -1;
            var_539 = false;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_476 = param1.readInteger();
            var_539 = param1.readInteger() > 0;
            return true;
        }
    }
}
