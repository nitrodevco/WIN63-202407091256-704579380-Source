package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1242 implements IMessageParser {

        public function class_1242() {
            super();
        }
        private var var_418: int;
        private var var_1102: int;

        public function get userId(): int {
            return var_418;
        }

        public function get furniCount(): int {
            return var_1102;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_418 = param1.readInteger();
            var_1102 = param1.readInteger();
            return true;
        }
    }
}
