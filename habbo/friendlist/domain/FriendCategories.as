package com.sulake.habbo.friendlist.domain {
    import assets.class_14

    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateMessageParser
    import com.sulake.habbo.friendlist.Util
    import com.sulake.habbo.friendlist.IFriendsView

    import flash.utils.Dictionary

    public class FriendCategories {

        private var _view: IFriendCategoriesDeps;

        private var _categories: Array;

        private var _friends: Dictionary;

        public function FriendCategories(param1: IFriendCategoriesDeps) {
            super();
            _categories = [];
            _friends = new Dictionary();
            _view = param1;
        }

        public function addFriend(friend: Friend): FriendCategory {
            var categoryId: int = friend.online ? friend.categoryId : -1;
            var category: FriendCategory = findCategory(categoryId);

            if (category != null) {
                category.addFriend(friend);
                _friends[friend.id] = friend;
                return category;
            }

            class_14.log("No category " + categoryId + " found for friend " + friend.id + ". Ignoring");
            return null;
        }

        public function sort(): void {
            for each (var category: FriendCategory in _categories) {
                category.sort();
            }
        }

        public function getSelectedFriends(): Array {
            var selectedFriends: Array = [];
            for each (var category: FriendCategory in _categories) {
                category.getSelectedFriends(selectedFriends);
            }
            return selectedFriends;
        }

        public function getSelectedFriend(): Friend {
            var selectedFriends: Array = getSelectedFriends();

            return selectedFriends.length == 1 ? selectedFriends[0] : null;
        }

        public function getAllFriends(): Dictionary {
            return _friends;
        }

        public function getFriendCount(onlyOnline: Boolean, includeHidden: Boolean = false): int {
            var totalFriendCount: int = 0;

            for each (var category: FriendCategory in _categories) {
                totalFriendCount += category.getFriendCount(onlyOnline, includeHidden);
            }

            return totalFriendCount;
        }

        public function getCategories(): Array {
            return _categories;
        }

        public function addCategory(param1: FriendCategory): void {
            _categories.push(param1);
        }

        public function findFriend(param1: int): Friend {
            return _friends[param1];
        }

        public function findCategory(categoryId: int): FriendCategory {
            for each (var category: FriendCategory in _categories) {
                if (category.id == categoryId) {
                    return category;
                }
            }
            return null;
        }

        public function onFriendListUpdate(event: IMessageEvent): void {
            var parser: FriendListUpdateMessageParser = FriendListUpdateEvent(event).getParser();

            updateCategories(parser.cats);

            // Handle removed friends
            for each (var removedFriendId: int in parser.removedFriendIds) {
                removeFriend(removedFriendId, true);
            }

            // Handle updated friends
            for each (var updatedFriendData: FriendData in parser.updatedFriends) {
                class_14.log("Got UPDATE: " + updatedFriendData.id + ", " + updatedFriendData.online + ", " + updatedFriendData.name + ", " + updatedFriendData.followingAllowed);

                _view.messenger.setFollowingAllowed(updatedFriendData.id, updatedFriendData.followingAllowed && updatedFriendData.online);

                var wasOnline: Boolean = isFriendOnline(updatedFriendData.id);

                if (wasOnline && !updatedFriendData.online) {
                    _view.messenger.setOnlineStatus(updatedFriendData.id, updatedFriendData.online);
                } else if (!wasOnline && updatedFriendData.online) {
                    _view.messenger.setOnlineStatus(updatedFriendData.id, updatedFriendData.online);
                    _view.view.setNewMessageArrived();
                }

                var wasSelected: Boolean = removeFriend(updatedFriendData.id, true);
                var updatedFriend: Friend = new Friend(updatedFriendData);
                updatedFriend.selected = wasSelected;

                addFriend(updatedFriend);
            }

            // Handle added friends
            for each (var addedFriendData: FriendData in parser.addedFriends) {
                var newFriend: Friend = new Friend(addedFriendData);
                class_14.log("Got INSERT: " + addedFriendData.id + ", " + addedFriendData.name);

                removeFriend(addedFriendData.id, true);
                addFriend(newFriend);
            }

            sort();
            _view.view.refreshList();
        }

        private function updateCategories(categories: Array): void {
            flushReceivedStatus();
            markCategoryAsReceived(-1);
            markCategoryAsReceived(0);

            for each (var newCategory: FriendCategory in categories) {
                var existingCategory: FriendCategory = findCategory(newCategory.id);
                if (existingCategory != null) {
                    existingCategory.received = true;
                    if (existingCategory.name != newCategory.name) {
                        existingCategory.name = newCategory.name;
                    }
                } else {
                    var newCat: FriendCategory = new FriendCategory(newCategory.id, newCategory.name);
                    newCat.received = true;
                    addCategory(newCat);
                }
            }

            for each (var category: FriendCategory in getCategoriesNotReceived()) {
                if (category.friends.length <= 0) {
                    Util.remove(_categories, category);
                    category.dispose();
                }
            }
        }

        private function markCategoryAsReceived(categoryId: int): void {
            var category: FriendCategory = findCategory(categoryId);
            if (category != null) {
                category.received = true;
            }
        }

        private function removeFriend(friendId: int, disposeFriend: Boolean): Boolean {
            var removedFriend: Friend = null;
            var wasSelected: Boolean = false;

            if (disposeFriend) {
                _friends[friendId] = null;
            }

            for each (var category: FriendCategory in _categories) {
                removedFriend = category.removeFriend(friendId);
                if (removedFriend != null) {
                    wasSelected = removedFriend.selected;
                    if (disposeFriend) {
                        removedFriend.dispose();
                    }
                }
            }

            return wasSelected;
        }

        private function flushReceivedStatus(): void {
            for each(var category: FriendCategory in _categories) {
                category.received = false;
            }
        }

        private function getCategoriesNotReceived(): Array {
            var categoriesNotReceived: Array = [];
            for each (var category: FriendCategory in _categories) {
                if (!category.received) {
                    categoriesNotReceived.push(category);
                }
            }
            return categoriesNotReceived;
        }

        private function isFriendOnline(friendId: int): Boolean {
            var friend: Friend = findFriend(friendId);

            return friend != null && friend.online;
        }

        public function getFriendNames(): Array {
            if (_friends == null) {
                return [];
            }

            var friendNames: Array = [];
            for each (var friend: Friend in _friends) {
                if (friend != null) {
                    friendNames.push(friend.name);
                }
            }

            return friendNames;
        }

        public function get view(): IFriendsView {
            return this._view.view;
        }
    }
}
