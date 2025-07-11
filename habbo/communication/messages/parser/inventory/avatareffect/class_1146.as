package com.sulake.habbo.communication.messages.parser.inventory.avatareffect {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1146 implements IMessageParser {

        public function class_1146() {
            super();
        }
        private var var_329: int;

        public function get type(): int {
            return var_329;
        }

        public function flush(): Boolean {
            var_329 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_329 = param1.readInteger();
            return true;
        }
    }
}
