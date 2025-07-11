package com.sulake.habbo.communication.messages.parser.friendlist {
    import assets.class_14

    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData

    [SecureSWF(rename="true")]
    public class FriendRequestsMessageParser implements IMessageParser {

        public function FriendRequestsMessageParser() {
            super();
        }
        private var _totalReqCount: int;
        private var _reqs: Array;

        public function get totalReqCount(): int {
            return this._totalReqCount;
        }

        public function get reqs(): Array {
            return this._reqs;
        }

        public function flush(): Boolean {
            this._reqs = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            this._totalReqCount = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            class_14.log("Received friend requests: " + _totalReqCount + ", " + _loc2_);
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                this._reqs.push(new FriendRequestData(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
