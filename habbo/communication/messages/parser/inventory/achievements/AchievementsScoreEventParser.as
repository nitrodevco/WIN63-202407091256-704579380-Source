package com.sulake.habbo.communication.messages.parser.inventory.achievements {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class AchievementsScoreEventParser implements IMessageParser {

        public function AchievementsScoreEventParser() {
            super();
        }
        private var var_367: int;

        public function get score(): int {
            return var_367;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_367 = param1.readInteger();
            return true;
        }
    }
}
