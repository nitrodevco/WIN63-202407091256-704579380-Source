package com.sulake.habbo.communication.messages.incoming.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class FriendCategoryData {

        public function FriendCategoryData(param1: IMessageDataWrapper) {
            super();
            this._id = param1.readInteger();
            this._name = param1.readString();
        }
        private var _id: int;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        public function get id(): int {
            return _id;
        }
    }
}
