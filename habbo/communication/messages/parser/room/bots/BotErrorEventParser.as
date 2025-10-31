package com.sulake.habbo.communication.messages.parser.room.bots {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class BotErrorEventParser implements IMessageParser {

        public function BotErrorEventParser() {
            super();
        }
        private var var_412: int;

        public function get errorCode(): int {
            return var_412;
        }

        public function flush(): Boolean {
            var_412 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_412 = param1.readInteger();
            return true;
        }
    }
}
