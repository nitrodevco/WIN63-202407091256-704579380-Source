package com.sulake.habbo.communication.messages.parser.inventory.badges {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class BadgeReceivedEventParser implements IMessageParser {

        public function BadgeReceivedEventParser() {
            super();
        }
        private var var_372: int;
        private var var_413: String;

        public function get badgeId(): int {
            return var_372;
        }

        public function get badgeCode(): String {
            return var_413;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_372 = param1.readInteger();
            var_413 = param1.readString();
            return true;
        }
    }
}
