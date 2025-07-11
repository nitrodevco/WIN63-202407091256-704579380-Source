package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1357 implements IMessageParser {

        public function class_1357() {
            super();
        }
        private var var_393: int;
        private var var_418: int;
        private var var_1498: int;

        public function get petId(): int {
            return var_393;
        }

        public function get userId(): int {
            return var_418;
        }

        public function get supplementType(): int {
            return var_1498;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_393 = param1.readInteger();
            var_418 = param1.readInteger();
            var_1498 = param1.readInteger();
            return true;
        }
    }
}
