package com.sulake.habbo.communication.messages.parser.crafting {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1640 {

        public function class_1640(param1: IMessageDataWrapper) {
            super();
            var_178 = param1.readInteger();
            var_592 = param1.readString();
        }
        private var var_178: int;
        private var var_592: String;

        public function get count(): int {
            return var_178;
        }

        public function get furnitureClassName(): String {
            return var_592;
        }
    }
}
