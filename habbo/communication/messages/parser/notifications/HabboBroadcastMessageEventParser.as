package com.sulake.habbo.communication.messages.parser.notifications {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class HabboBroadcastMessageEventParser implements IMessageParser {

        public function HabboBroadcastMessageEventParser() {
            super();
        }
        private var var_639: String = "";

        public function get messageText(): String {
            return var_639;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_639 = param1.readString();
            return true;
        }
    }
}
