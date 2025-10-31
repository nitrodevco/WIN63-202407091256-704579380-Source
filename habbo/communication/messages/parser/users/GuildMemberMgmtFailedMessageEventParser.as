package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class GuildMemberMgmtFailedMessageEventParser implements IMessageParser {

        public function GuildMemberMgmtFailedMessageEventParser() {
            super();
        }
        private var var_364: int;
        private var var_326: int;

        public function get guildId(): int {
            return var_364;
        }

        public function get reason(): int {
            return var_326;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_364 = param1.readInteger();
            var_326 = param1.readInteger();
            return true;
        }
    }
}
