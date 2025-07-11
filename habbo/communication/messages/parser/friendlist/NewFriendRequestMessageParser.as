package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData

    [SecureSWF(rename="true")]
    public class NewFriendRequestMessageParser implements IMessageParser {

        public function NewFriendRequestMessageParser() {
            super();
        }
        private var var_1537: FriendRequestData;

        public function get req(): FriendRequestData {
            return this.var_1537;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this.var_1537 = new FriendRequestData(param1);
            return true;
        }
    }
}
