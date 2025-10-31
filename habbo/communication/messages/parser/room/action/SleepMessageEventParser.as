package com.sulake.habbo.communication.messages.parser.room.action {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class SleepMessageEventParser implements IMessageParser {

        public function SleepMessageEventParser() {
            super();
        }
        private var var_418: int = 0;
        private var var_1423: Boolean = false;

        public function get userId(): int {
            return var_418;
        }

        public function get sleeping(): Boolean {
            return var_1423;
        }

        public function flush(): Boolean {
            var_418 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_418 = param1.readInteger();
            var_1423 = param1.readBoolean();
            return true;
        }
    }
}
