package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class RespectNotificationMessageEventParser implements IMessageParser {

        public function RespectNotificationMessageEventParser() {
            super();
        }
        private var var_418: int = 0;
        private var var_1501: int = 0;

        public function get userId(): int {
            return var_418;
        }

        public function get respectTotal(): int {
            return var_1501;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_418 = param1.readInteger();
            var_1501 = param1.readInteger();
            return true;
        }
    }
}
