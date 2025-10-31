package com.sulake.habbo.communication.messages.parser.crafting {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CraftingResultMessageEventParser implements IMessageParser {

        public function CraftingResultMessageEventParser() {
            super();
        }
        private var var_258: Boolean;
        private var var_1236: class_1649;

        public function get success(): Boolean {
            return var_258;
        }

        public function get productData(): class_1649 {
            return var_1236;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_258 = param1.readBoolean();
            if (var_258) {
                var_1236 = new class_1649(param1);
            }
            return true;
        }

        public function flush(): Boolean {
            var_258 = false;
            return true;
        }
    }
}
