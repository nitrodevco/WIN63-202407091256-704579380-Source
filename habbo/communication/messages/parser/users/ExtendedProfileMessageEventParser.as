package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.users.class_1581

    [SecureSWF(rename="true")]
    public class ExtendedProfileMessageEventParser implements IMessageParser {

        public function ExtendedProfileMessageEventParser() {
            super();
        }
        private var var_47: class_1581;

        public function get data(): class_1581 {
            return var_47;
        }

        public function flush(): Boolean {
            var_47 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new class_1581(param1);
            return true;
        }
    }
}
