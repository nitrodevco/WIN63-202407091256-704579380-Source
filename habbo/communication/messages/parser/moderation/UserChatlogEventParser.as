package com.sulake.habbo.communication.messages.parser.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.moderation.class_1644

    [SecureSWF(rename="true")]
    public class UserChatlogEventParser implements IMessageParser {

        public function UserChatlogEventParser() {
            super();
        }
        private var var_47: class_1644;

        public function get data(): class_1644 {
            return var_47;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new class_1644(param1);
            return true;
        }
    }
}
