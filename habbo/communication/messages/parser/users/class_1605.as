package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1605 implements IMessageParser {

        public function class_1605() {
            super();
        }
        private var var_1180: int;

        private var _groupId: int;

        public function get groupId(): int {
            return _groupId;
        }

        public function get baseRoomId(): int {
            return var_1180;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1180 = param1.readInteger();
            _groupId = param1.readInteger();
            return true;
        }
    }
}
