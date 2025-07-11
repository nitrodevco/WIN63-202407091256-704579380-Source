package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1144 implements IMessageParser {

        public function class_1144() {
            super();
        }
        private var var_1102: int;

        public function get furniCount(): int {
            return var_1102;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1102 = param1.readInteger();
            return true;
        }
    }
}
