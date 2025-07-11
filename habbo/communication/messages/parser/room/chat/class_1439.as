package com.sulake.habbo.communication.messages.parser.room.chat {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1439 implements IMessageParser {

        public function class_1439() {
            super();
        }
        private var var_1172: int = 0;

        public function get secondsRemaining(): int {
            return var_1172;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1172 = param1.readInteger();
            return true;
        }
    }
}
