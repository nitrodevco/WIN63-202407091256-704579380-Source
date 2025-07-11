package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1320 implements IMessageParser {

        public function class_1320() {
            super();
        }

        private var _userName: String;

        public function get userName(): String {
            return _userName;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _userName = param1.readString();
            return true;
        }

        public function flush(): Boolean {
            _userName = null;
            return true;
        }
    }
}
