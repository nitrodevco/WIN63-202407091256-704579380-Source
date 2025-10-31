package com.sulake.habbo.communication.messages.parser.inventory.bots {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class BotRemovedFromInventoryEventParser implements IMessageParser {

        public function BotRemovedFromInventoryEventParser() {
            super();
        }
        private var var_517: int;

        public function get itemId(): int {
            return var_517;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_517 = param1.readInteger();
            return true;
        }
    }
}
