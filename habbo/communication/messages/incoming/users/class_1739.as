package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1739 {

        public function class_1739(param1: IMessageDataWrapper = null) {
            super();
            var_1333 = param1.readInteger();
            var_849 = param1.readString();
            var_1325 = param1.readDouble();
            var_921 = param1.readInteger();
            var_1505 = param1.readInteger();
            var_1344 = param1.readInteger();
            var_1237 = param1.readInteger();
            var_905 = param1.readInteger();
            var_829 = param1.readInteger();
        }
        private var var_1333: int;
        private var var_849: String;
        private var var_1325: Number;
        private var var_921: int;
        private var var_1505: int;
        private var var_1344: int;
        private var var_1237: int;
        private var var_905: int;
        private var var_829: int;

        public function get currentHcStreak(): int {
            return var_1333;
        }

        public function get firstSubscriptionDate(): String {
            return var_849;
        }

        public function get kickbackPercentage(): Number {
            return var_1325;
        }

        public function get totalCreditsMissed(): int {
            return var_921;
        }

        public function get totalCreditsRewarded(): int {
            return var_1505;
        }

        public function get totalCreditsSpent(): int {
            return var_1344;
        }

        public function get creditRewardForStreakBonus(): int {
            return var_1237;
        }

        public function get creditRewardForMonthlySpent(): int {
            return var_905;
        }

        public function get timeUntilPayday(): int {
            return var_829;
        }
    }
}
