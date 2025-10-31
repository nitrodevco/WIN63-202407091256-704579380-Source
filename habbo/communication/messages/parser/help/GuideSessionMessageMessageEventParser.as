package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class GuideSessionMessageMessageEventParser implements IMessageParser {

        public function GuideSessionMessageMessageEventParser() {
            super();
        }
        private var var_576: String;
        private var var_779: int;

        public function get chatMessage(): String {
            return var_576;
        }

        public function get senderId(): int {
            return var_779;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_576 = param1.readString();
            var_779 = param1.readInteger();
            return true;
        }
    }
}
