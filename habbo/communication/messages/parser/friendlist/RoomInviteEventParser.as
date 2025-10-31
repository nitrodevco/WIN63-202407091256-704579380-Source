package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class RoomInviteEventParser implements IMessageParser {

        public function RoomInviteEventParser() {
            super();
        }
        private var _senderId: int;
        private var _messageText: String;

        public function get senderId(): int {
            return this._senderId;
        }

        public function get messageText(): String {
            return this._messageText;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this._senderId = param1.readInteger();
            this._messageText = param1.readString();
            return true;
        }
    }
}
