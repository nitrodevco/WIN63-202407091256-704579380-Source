package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ItemRemoveMessageEventParser implements IMessageParser {

        public function ItemRemoveMessageEventParser() {
            super();
        }
        private var var_517: int = 0;
        private var var_582: int = -1;

        public function get itemId(): int {
            return var_517;
        }

        public function get pickerId(): int {
            return var_582;
        }

        public function flush(): Boolean {
            var_517 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_517 = int(param1.readString());
            var_582 = param1.readInteger();
            return true;
        }
    }
}
