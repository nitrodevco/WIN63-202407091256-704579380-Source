package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData

    [SecureSWF(rename="true")]
    public class FriendsListFragmentMessageParser implements IMessageParser {

        public function FriendsListFragmentMessageParser() {
            super();
        }
        protected var _totalFragments: int;
        protected var _fragmentNo: int;
        private var _friendFragment: Array;

        public function get totalFragments(): int {
            return _totalFragments;
        }

        public function get fragmentNo(): int {
            return _fragmentNo;
        }

        public function get friendFragment(): Array {
            return _friendFragment;
        }

        public function parse(data: IMessageDataWrapper): Boolean {
            _totalFragments = data.readInteger();
            _fragmentNo = data.readInteger();

            var friendCount: int = data.readInteger();
            _friendFragment = new Array(friendCount);

            for (var i: int = 0; i < friendCount; i++) {
                _friendFragment[i] = new FriendData(data);
            }

            return true;
        }

        public function flush(): Boolean {
            _friendFragment = [];
            return true;
        }
    }
}
