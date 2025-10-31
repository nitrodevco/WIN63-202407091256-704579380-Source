package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class UserRemoveMessageEventParser implements IMessageParser {

        public function UserRemoveMessageEventParser() {
            super();
        }
        private var var_280: int = 0;

        public function get id(): int {
            return var_280;
        }

        public function flush(): Boolean {
            var_280 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_280 = int(param1.readString());
            return true;
        }
    }
}
