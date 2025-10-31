package com.sulake.habbo.communication.messages.parser.notifications {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class InfoFeedEnableMessageEventParser implements IMessageParser {

        public function InfoFeedEnableMessageEventParser() {
            super();
        }
        private var var_593: Boolean;

        public function get enabled(): Boolean {
            return var_593;
        }

        public function flush(): Boolean {
            var_593 = false;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_593 = param1.readBoolean();
            return true;
        }
    }
}
