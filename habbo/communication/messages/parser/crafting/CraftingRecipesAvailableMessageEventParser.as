package com.sulake.habbo.communication.messages.parser.crafting {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CraftingRecipesAvailableMessageEventParser implements IMessageParser {

        public function CraftingRecipesAvailableMessageEventParser() {
            super();
        }
        private var var_439: Boolean;
        private var var_178: int;

        public function get count(): int {
            return var_178;
        }

        public function get recipeComplete(): Boolean {
            return var_439;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_178 = param1.readInteger();
            var_439 = param1.readBoolean();
            return true;
        }

        public function flush(): Boolean {
            var_178 = 0;
            var_439 = false;
            return true;
        }
    }
}
