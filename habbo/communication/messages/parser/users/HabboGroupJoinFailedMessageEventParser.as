package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class HabboGroupJoinFailedMessageEventParser implements IMessageParser {

        public static const const_13: int = 4;

        public function HabboGroupJoinFailedMessageEventParser() {
            super();
        }
        private var var_326: int;

        public function get reason(): int {
            return var_326;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_326 = param1.readInteger();
            return true;
        }
    }
}
