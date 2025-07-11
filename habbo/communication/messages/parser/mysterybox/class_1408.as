package com.sulake.habbo.communication.messages.parser.mysterybox {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1408 implements IMessageParser {

        public function class_1408() {
            super();
        }
        private var var_489: String;
        private var var_390: int;

        public function get contentType(): String {
            return var_489;
        }

        public function get classId(): int {
            return var_390;
        }

        public function flush(): Boolean {
            var_489 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_489 = param1.readString();
            var_390 = param1.readInteger();
            return true;
        }
    }
}
