package com.sulake.habbo.communication.messages.incoming.quest {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1760 {

        public function class_1760(param1: IMessageDataWrapper) {
            super();
            var_1512 = param1.readInteger();
            var_1135 = param1.readString();
            var_1379 = param1.readInteger();
            var_1383 = param1.readString();
            var_1331 = param1.readBoolean();
            _localizedName = param1.readString();
        }
        private var var_1512: int;
        private var var_1135: String;
        private var var_1379: int;
        private var var_1383: String;
        private var var_1331: Boolean;

        private var _localizedName: String;

        public function get localizedName(): String {
            return _localizedName;
        }

        public function get communityGoalId(): int {
            return var_1512;
        }

        public function get communityGoalCode(): String {
            return var_1135;
        }

        public function get userRank(): int {
            return var_1379;
        }

        public function get rewardCode(): String {
            return var_1383;
        }

        public function get badge(): Boolean {
            return var_1331;
        }
    }
}
