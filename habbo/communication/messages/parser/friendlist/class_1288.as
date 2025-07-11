package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1288 implements IMessageParser {

        public function class_1288() {
            super();
        }
        private var var_912: int;

        public function get unreadMessageCount(): int {
            return var_912;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_912 = param1.readInteger();
            return true;
        }
    }
}
