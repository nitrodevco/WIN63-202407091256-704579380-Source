package com.sulake.habbo.communication.messages.parser.crafting {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1649 {

        public function class_1649(param1: IMessageDataWrapper) {
            super();
            var_1334 = param1.readString();
            var_394 = param1.readString();
            var_592 = param1.readString();
        }
        private var var_1334: String;
        private var var_394: String;
        private var var_592: String;

        public function get recipeCode(): String {
            return var_1334;
        }

        public function get productCode(): String {
            return var_394;
        }

        public function get furnitureClassName(): String {
            return var_592;
        }
    }
}
