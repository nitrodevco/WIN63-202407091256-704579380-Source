package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1419 implements IMessageParser {

        public function class_1419() {
            super();
        }
        private var var_553: int = -1;
        private var var_894: String;
        private var var_368: String;

        public function get typeCode(): int {
            return var_553;
        }

        public function get avatarId(): String {
            return var_894;
        }

        public function get message(): String {
            return var_368;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_894 = param1.readString();
            var_553 = param1.readInteger();
            var_368 = param1.readString();
            return true;
        }
    }
}
