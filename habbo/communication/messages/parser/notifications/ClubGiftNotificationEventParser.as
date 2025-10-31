package com.sulake.habbo.communication.messages.parser.notifications {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ClubGiftNotificationEventParser implements IMessageParser {

        public function ClubGiftNotificationEventParser() {
            super();
        }
        private var var_1513: int;

        public function get numGifts(): int {
            return var_1513;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1513 = param1.readInteger();
            return true;
        }
    }
}
