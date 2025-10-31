package com.sulake.habbo.communication.messages.parser.quest {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ConcurrentUsersGoalProgressMessageEventParser implements IMessageParser {

        public function ConcurrentUsersGoalProgressMessageEventParser() {
            super();
        }
        private var var_149: int;
        private var var_554: int;
        private var var_608: int;

        public function get state(): int {
            return var_149;
        }

        public function get userCount(): int {
            return var_554;
        }

        public function get userCountGoal(): int {
            return var_608;
        }

        public function flush(): Boolean {
            var_149 = -1;
            var_554 = -1;
            var_608 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_149 = param1.readInteger();
            var_554 = param1.readInteger();
            var_608 = param1.readInteger();
            return true;
        }
    }
}
