package com.sulake.habbo.communication.messages.parser.groupforums {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1627 implements IMessageParser {

        public function class_1627() {
            super();
        }
        private var var_345: int;

        private var var_368: class_1666;

        private var _groupId: int;

        public function get groupId(): int {
            return _groupId;
        }

        public function get threadId(): int {
            return var_345;
        }

        public function get message(): class_1666 {
            return var_368;
        }

        public function flush(): Boolean {
            _groupId = -1;
            var_345 = -1;
            var_368 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _groupId = param1.readInteger();
            var_345 = param1.readInteger();
            var_368 = class_1666.readFromMessage(param1);
            return true;
        }
    }
}
