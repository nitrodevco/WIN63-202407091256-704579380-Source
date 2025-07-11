package com.sulake.habbo.communication.messages.incoming.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1741 {

        public function class_1741(param1: IMessageDataWrapper) {
            super();
            var_779 = param1.readInteger();
            _senderName = param1.readString();
            var_1283 = param1.readString();
            var_368 = param1.readString();
            var_1468 = param1.readInteger();
            var_494 = param1.readString();
        }
        private var var_779: int;
        private var var_1283: String;

        private var var_368: String;

        private var var_1468: int;

        private var var_494: String;

        private var _senderName: String;

        public function get senderName(): String {
            return _senderName;
        }

        public function get senderId(): int {
            return var_779;
        }

        public function get senderFigure(): String {
            return var_1283;
        }

        public function get message(): String {
            return var_368;
        }

        public function get secondsSinceSent(): int {
            return var_1468;
        }

        public function get messageId(): String {
            return var_494;
        }
    }
}
