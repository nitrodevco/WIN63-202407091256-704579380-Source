package com.sulake.habbo.communication.messages.parser.inventory.trading {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1415 implements IMessageParser {

        public static const const_254: int = 7;

        public static const const_353: int = 8;

        public function class_1415() {
            super();
        }
        private var var_326: int;

        private var _otherUserName: String;

        public function get otherUserName(): String {
            return _otherUserName;
        }

        public function get reason(): int {
            return var_326;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_326 = param1.readInteger();
            _otherUserName = param1.readString();
            return true;
        }
    }
}
