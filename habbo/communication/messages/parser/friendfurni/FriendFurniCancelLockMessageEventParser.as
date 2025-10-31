package com.sulake.habbo.communication.messages.parser.friendfurni {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class FriendFurniCancelLockMessageEventParser implements IMessageParser {

        public function FriendFurniCancelLockMessageEventParser() {
            super();
        }

        private var _stuffId: int;

        public function get stuffId(): int {
            return _stuffId;
        }

        public function flush(): Boolean {
            _stuffId = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _stuffId = param1.readInteger();
            return true;
        }
    }
}
