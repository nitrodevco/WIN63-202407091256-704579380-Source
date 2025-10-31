package com.sulake.habbo.communication.messages.parser.vault {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class IncomeRewardClaimResponseMessageEventParser implements IMessageParser {

        public function IncomeRewardClaimResponseMessageEventParser() {
            super();
        }
        private var var_773: int;
        private var var_152: Boolean;

        public function get rewardCategory(): int {
            return var_773;
        }

        public function get result(): Boolean {
            return var_152;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_773 = param1.readByte();
            var_152 = param1.readBoolean();
            return true;
        }

        public function flush(): Boolean {
            return true;
        }
    }
}
