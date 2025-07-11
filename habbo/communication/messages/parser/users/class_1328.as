package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1328 implements IMessageParser {

        public function class_1328() {
            super();
        }
        private var var_152: int;

        private var _nameValidationInfo: String;

        public function get nameValidationInfo(): String {
            return _nameValidationInfo;
        }

        public function get result(): int {
            return var_152;
        }

        public function flush(): Boolean {
            var_152 = -1;
            _nameValidationInfo = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_152 = param1.readInteger();
            _nameValidationInfo = param1.readString();
            return true;
        }
    }
}
