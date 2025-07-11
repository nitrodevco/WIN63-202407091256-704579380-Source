package com.sulake.habbo.communication.messages.parser.availability {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1255 implements IMessageParser {

        public function class_1255() {
            super();
        }
        private var var_459: int;

        public function get minutesUntilClosing(): int {
            return var_459;
        }

        public function flush(): Boolean {
            var_459 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_459 = param1.readInteger();
            return true;
        }
    }
}
