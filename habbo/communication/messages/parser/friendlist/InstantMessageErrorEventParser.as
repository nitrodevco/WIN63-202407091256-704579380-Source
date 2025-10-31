package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class InstantMessageErrorEventParser implements IMessageParser {

        public function InstantMessageErrorEventParser() {
            super();
        }
        private var _errorCode: int;
        private var _userId: int;
        private var _message: String;

        public function get errorCode(): int {
            return this._errorCode;
        }

        public function get userId(): int {
            return this._userId;
        }

        public function get message(): String {
            return this._message;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this._errorCode = param1.readInteger();
            this._userId = param1.readInteger();
            this._message = param1.readString();
            return true;
        }
    }
}
