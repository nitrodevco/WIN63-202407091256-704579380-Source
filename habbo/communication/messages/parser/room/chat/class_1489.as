package com.sulake.habbo.communication.messages.parser.room.chat {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1489 implements IMessageParser {

        public function class_1489() {
            super();
        }
        private var var_418: int = 0;
        private var var_514: Boolean = false;

        public function get userId(): int {
            return var_418;
        }

        public function get isTyping(): Boolean {
            return var_514;
        }

        public function flush(): Boolean {
            var_418 = 0;
            var_514 = false;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_418 = param1.readInteger();
            var_514 = param1.readInteger() == 1;
            return true;
        }
    }
}
