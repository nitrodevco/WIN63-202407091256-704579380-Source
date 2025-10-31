package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.users.class_1739

    [SecureSWF(rename="true")]
    public class ScrSendKickbackInfoMessageEventParser implements IMessageParser {

        public function ScrSendKickbackInfoMessageEventParser() {
            super();
        }
        private var var_47: class_1739;

        public function get data(): class_1739 {
            return var_47;
        }

        public function flush(): Boolean {
            var_47 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new class_1739(param1);
            return true;
        }
    }
}
