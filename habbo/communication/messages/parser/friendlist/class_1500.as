package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1500 implements IMessageParser {

        public function class_1500() {
            super();
        }
        private var var_1517: int;
        private var var_639: String;
        private var var_1468: int;
        private var var_494: String;
        private var var_1564: int;
        private var var_779: int;
        private var var_1283: String;

        private var _senderName: String;

        public function get senderName(): String {
            return _senderName;
        }

        public function get chatId(): int {
            return this.var_1517;
        }

        public function get messageText(): String {
            return this.var_639;
        }

        public function get secondsSinceSent(): int {
            return var_1468;
        }

        public function get messageId(): String {
            return var_494;
        }

        public function get confirmationId(): int {
            return var_1564;
        }

        public function get senderId(): int {
            return var_779;
        }

        public function get senderFigure(): String {
            return var_1283;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this.var_1517 = param1.readInteger();
            this.var_639 = param1.readString();
            this.var_1468 = param1.readInteger();
            this.var_494 = param1.readString();
            this.var_1564 = param1.readInteger();
            this.var_779 = param1.readInteger();
            this._senderName = param1.readString();
            this.var_1283 = param1.readString();
            return true;
        }
    }
}
