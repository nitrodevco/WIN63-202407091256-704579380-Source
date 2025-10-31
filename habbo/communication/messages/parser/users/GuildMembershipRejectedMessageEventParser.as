package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class GuildMembershipRejectedMessageEventParser implements IMessageParser {

        public function GuildMembershipRejectedMessageEventParser() {
            super();
        }
        private var var_364: int;
        private var var_418: int;

        public function get guildId(): int {
            return var_364;
        }

        public function get userId(): int {
            return var_418;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_364 = param1.readInteger();
            var_418 = param1.readInteger();
            return true;
        }
    }
}
