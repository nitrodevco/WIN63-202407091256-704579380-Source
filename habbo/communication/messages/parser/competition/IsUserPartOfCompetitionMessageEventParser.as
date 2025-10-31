package com.sulake.habbo.communication.messages.parser.competition {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class IsUserPartOfCompetitionMessageEventParser implements IMessageParser {

        public function IsUserPartOfCompetitionMessageEventParser() {
            super();
        }
        private var var_925: Boolean;
        private var var_1458: int;

        public function get isPartOf(): Boolean {
            return var_925;
        }

        public function get targetId(): int {
            return var_1458;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_925 = param1.readBoolean();
            var_1458 = param1.readInteger();
            return true;
        }
    }
}
