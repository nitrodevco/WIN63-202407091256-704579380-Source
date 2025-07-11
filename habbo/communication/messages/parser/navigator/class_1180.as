package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1180 implements IMessageParser {

        public function class_1180() {
            super();
        }
        private var var_550: String;
        private var var_952: int;

        public function get globalId(): String {
            return var_550;
        }

        public function get convertedId(): int {
            return var_952;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_550 = param1.readString();
            var_952 = param1.readInteger();
            return true;
        }

        public function flush(): Boolean {
            var_550 = null;
            return true;
        }
    }
}
