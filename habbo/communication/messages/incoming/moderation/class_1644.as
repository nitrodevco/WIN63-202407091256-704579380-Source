package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1644 {

        public function class_1644(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            _rooms = [];
            super();
            var_418 = param1.readInteger();
            _userName = param1.readString();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _rooms.push(new class_1757(param1));
                _loc3_++;
            }
        }
        private var var_418: int;

        private var _userName: String;

        public function get userName(): String {
            return _userName;
        }

        private var _rooms: Array;

        public function get rooms(): Array {
            return _rooms;
        }

        public function get userId(): int {
            return var_418;
        }
    }
}
