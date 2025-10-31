package com.sulake.habbo.communication.messages.parser.room.session {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class HanditemConfigurationMessageEventParser implements IMessageParser {

        public function HanditemConfigurationMessageEventParser() {
            super();
        }
        private var var_401: Boolean = false;

        public function get isHanditemControlBlocked(): Boolean {
            return var_401;
        }

        public function flush(): Boolean {
            var_401 = false;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_401 = param1.readBoolean();
            return true;
        }
    }
}
