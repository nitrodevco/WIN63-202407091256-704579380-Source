package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.users.class_1251

    [SecureSWF(rename="true")]
    public class GuildMembershipUpdatedMessageEventParser implements IMessageParser {

        public function GuildMembershipUpdatedMessageEventParser() {
            super();
        }
        private var var_364: int;
        private var var_47: class_1251;

        public function get guildId(): int {
            return var_364;
        }

        public function get data(): class_1251 {
            return var_47;
        }

        public function flush(): Boolean {
            var_47 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_364 = param1.readInteger();
            var_47 = new class_1251(param1);
            return true;
        }
    }
}
