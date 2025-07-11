package com.sulake.habbo.communication.messages.parser.advertisement {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1118 implements IMessageParser {

        public function class_1118() {
            super();
        }
        private var var_412: int = 0;
        private var var_1301: String;

        public function get errorCode(): int {
            return var_412;
        }

        public function get filteredText(): String {
            return var_1301;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_412 = param1.readInteger();
            var_1301 = param1.readString();
            return true;
        }
    }
}
