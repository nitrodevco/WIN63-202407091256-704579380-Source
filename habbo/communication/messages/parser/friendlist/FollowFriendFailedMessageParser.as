package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class FollowFriendFailedMessageParser implements IMessageParser {

        public function FollowFriendFailedMessageParser() {
            super();
        }
        private var var_412: int;

        public function get errorCode(): int {
            return this.var_412;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this.var_412 = param1.readInteger();
            return true;
        }
    }
}
