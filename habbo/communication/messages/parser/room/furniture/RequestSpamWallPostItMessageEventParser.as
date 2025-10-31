package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class RequestSpamWallPostItMessageEventParser implements IMessageParser {

        public function RequestSpamWallPostItMessageEventParser() {
            super();
        }
        private var var_517: int;
        private var var_587: String;

        public function get itemId(): int {
            return var_517;
        }

        public function get location(): String {
            return var_587;
        }

        public function flush(): Boolean {
            var_517 = -1;
            var_587 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_517 = param1.readInteger();
            var_587 = param1.readString();
            return true;
        }
    }
}
