package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1469 implements IMessageParser {

        public function class_1469() {
            super();
        }
        private var var_516: int;
        private var var_547: String;

        public function get questionId(): int {
            return var_516;
        }

        public function get answerText(): String {
            return var_547;
        }

        public function flush(): Boolean {
            var_516 = -1;
            var_547 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_516 = param1.readInteger();
            var_547 = param1.readString();
            return true;
        }
    }
}
