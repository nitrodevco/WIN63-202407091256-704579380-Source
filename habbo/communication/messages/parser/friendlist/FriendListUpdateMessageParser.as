package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData

    [SecureSWF(rename="true")]
    public class FriendListUpdateMessageParser implements IMessageParser {

        public function FriendListUpdateMessageParser() {
            super();
        }
        private var _categories: Array;
        private var _removedFriendIds: Array;
        private var _addedFriends: Array;
        private var _updatedFriends: Array;

        public function get cats(): Array {
            return this._categories;
        }

        public function get removedFriendIds(): Array {
            return this._removedFriendIds;
        }

        public function get addedFriends(): Array {
            return this._addedFriends;
        }

        public function get updatedFriends(): Array {
            return this._updatedFriends;
        }

        public function flush(): Boolean {
            this._categories = [];
            this._removedFriendIds = [];
            this._addedFriends = [];
            this._updatedFriends = [];
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean {
            var numCategories: int = data.readInteger();

            // Initialize categories
            for (var i: int = 0; i < numCategories; i++) {
                this._categories.push(new FriendCategoryData(data));
            }

            var numFriends: int = data.readInteger();

            // Initialize friends
            for (var j: int = 0; j < numFriends; j++) {
                var actionType: int = data.readInteger();

                if (actionType == -1) {
                    var removedFriendId: int = data.readInteger();
                    this._removedFriendIds.push(removedFriendId);
                } else if (actionType == 0) {
                    this._updatedFriends.push(new FriendData(data));
                } else if (actionType == 1) {
                    this._addedFriends.push(new FriendData(data));
                }
            }

            return true;
        }
    }
}
