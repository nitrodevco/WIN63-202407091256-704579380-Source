package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData

    [SecureSWF(rename="true")]
    public class MessengerInitParser implements IMessageParser {

        public function MessengerInitParser() {
            super();
        }
        private var _userFriendLimit: int;
        private var _normalFriendLimit: int;
        private var _extendedFriendLimit: int;
        private var _categories: Array;

        public function get userFriendLimit(): int {
            return this._userFriendLimit;
        }

        public function get normalFriendLimit(): int {
            return this._normalFriendLimit;
        }

        public function get extendedFriendLimit(): int {
            return this._extendedFriendLimit;
        }

        public function get categories(): Array {
            return this._categories;
        }

        public function flush(): Boolean {
            this._categories = [];
            return true;
        }

        public function parse(dataWrapper: IMessageDataWrapper): Boolean {
            this._userFriendLimit = dataWrapper.readInteger();
            this._normalFriendLimit = dataWrapper.readInteger();
            this._extendedFriendLimit = dataWrapper.readInteger();

            var categoryCount: int = dataWrapper.readInteger();
            for (var i: int = 0; i < categoryCount; i++) {
                this._categories.push(new FriendCategoryData(dataWrapper));
            }

            return true;
        }
    }
}
