package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1268 implements IMessageParser {

        public function class_1268() {
            super();
        }

        private var _groupId: int;

        public function get groupId(): int {
            return _groupId;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _groupId = param1.readInteger();
            return true;
        }
    }
}
