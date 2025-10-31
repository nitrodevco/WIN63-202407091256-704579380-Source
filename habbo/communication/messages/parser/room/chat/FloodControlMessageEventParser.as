package com.sulake.habbo.communication.messages.parser.room.chat {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class FloodControlMessageEventParser implements IMessageParser {

        public function FloodControlMessageEventParser() {
            super();
        }
        private var var_484: int = 0;

        public function get seconds(): int {
            return var_484;
        }

        public function flush(): Boolean {
            var_484 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_484 = param1.readInteger();
            return true;
        }
    }
}
