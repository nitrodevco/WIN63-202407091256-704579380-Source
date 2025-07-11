package com.sulake.habbo.communication.messages.parser.handshake {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1458 implements IMessageParser {

        public function class_1458() {
            super();
        }
        private var var_1262: int;

        public function get noobnessLevel(): int {
            return var_1262;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1262 = param1.readInteger();
            return true;
        }
    }
}
