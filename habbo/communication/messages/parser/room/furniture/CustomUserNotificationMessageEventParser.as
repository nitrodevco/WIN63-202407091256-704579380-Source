package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CustomUserNotificationMessageEventParser implements IMessageParser {

        public function CustomUserNotificationMessageEventParser() {
            super();
        }
        private var var_1078: int = 0;

        public function get code(): int {
            return var_1078;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_1078 = param1.readInteger();
            return true;
        }
    }
}
