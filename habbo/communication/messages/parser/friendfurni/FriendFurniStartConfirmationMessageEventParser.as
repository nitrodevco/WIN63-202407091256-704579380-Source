package com.sulake.habbo.communication.messages.parser.friendfurni {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class FriendFurniStartConfirmationMessageEventParser implements IMessageParser {

        public function FriendFurniStartConfirmationMessageEventParser() {
            super();
        }
        private var var_385: Boolean;

        private var _stuffId: int;

        public function get stuffId(): int {
            return _stuffId;
        }

        public function get isOwner(): Boolean {
            return var_385;
        }

        public function flush(): Boolean {
            _stuffId = -1;
            var_385 = false;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _stuffId = param1.readInteger();
            var_385 = param1.readBoolean();
            return true;
        }
    }
}
