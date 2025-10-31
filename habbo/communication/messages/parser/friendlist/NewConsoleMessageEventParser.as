package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class NewConsoleMessageEventParser implements IMessageParser {

        public function NewConsoleMessageEventParser() {
            super();
        }
        private var _chatId: int;
        private var _messageText: String;
        private var _secondsSinceSent: int;
        private var _messageId: String;
        private var _confirmationId: int;
        private var _senderId: int;
        private var _senderFigure: String;

        private var _senderName: String;

        public function get senderName(): String {
            return _senderName;
        }

        public function get chatId(): int {
            return this._chatId;
        }

        public function get messageText(): String {
            return this._messageText;
        }

        public function get secondsSinceSent(): int {
            return _secondsSinceSent;
        }

        public function get messageId(): String {
            return _messageId;
        }

        public function get confirmationId(): int {
            return _confirmationId;
        }

        public function get senderId(): int {
            return _senderId;
        }

        public function get senderFigure(): String {
            return _senderFigure;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this._chatId = param1.readInteger();
            this._messageText = param1.readString();
            this._secondsSinceSent = param1.readInteger();
            this._messageId = param1.readString();
            this._confirmationId = param1.readInteger();
            this._senderId = param1.readInteger();
            this._senderName = param1.readString();
            this._senderFigure = param1.readString();
            return true;
        }
    }
}
