package com.sulake.habbo.communication.messages.parser.competition {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CompetitionVotingInfoMessageEventParser implements IMessageParser {

        public function CompetitionVotingInfoMessageEventParser() {
            super();
        }
        private var var_427: int;
        private var var_891: String;
        private var var_296: int;
        private var var_1036: int;

        public function get goalId(): int {
            return var_427;
        }

        public function get goalCode(): String {
            return var_891;
        }

        public function get isVotingAllowedForUser(): Boolean {
            return var_296 == 0;
        }

        public function get votesRemaining(): int {
            return var_1036;
        }

        public function get resultCode(): int {
            return var_296;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_427 = param1.readInteger();
            var_891 = param1.readString();
            var_296 = param1.readInteger();
            var_1036 = param1.readInteger();
            return true;
        }
    }
}
