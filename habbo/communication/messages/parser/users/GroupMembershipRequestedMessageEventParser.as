package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.users.class_1251

    [SecureSWF(rename="true")]
    public class GroupMembershipRequestedMessageEventParser implements IMessageParser {

        public function GroupMembershipRequestedMessageEventParser() {
            super();
        }
        private var var_505: class_1251;

        private var _groupId: int;

        public function get groupId(): int {
            return _groupId;
        }

        public function get requester(): class_1251 {
            return var_505;
        }

        public function flush(): Boolean {
            var_505 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _groupId = param1.readInteger();
            var_505 = new class_1251(param1);
            return true;
        }
    }
}
