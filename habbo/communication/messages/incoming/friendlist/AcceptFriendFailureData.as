package com.sulake.habbo.communication.messages.incoming.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class AcceptFriendFailureData {

        public function AcceptFriendFailureData(param1: IMessageDataWrapper) {
            super();
            this.var_779 = param1.readInteger();
            this.var_412 = param1.readInteger();
        }
        private var var_779: int;
        private var var_412: int;

        public function get senderId(): int {
            return this.var_779;
        }

        public function get errorCode(): int {
            return this.var_412;
        }
    }
}
