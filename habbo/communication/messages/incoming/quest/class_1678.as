package com.sulake.habbo.communication.messages.incoming.quest {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.runtime.IDisposable

    [SecureSWF(rename="true")]
    public class class_1678 implements IDisposable {

        public function class_1678(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            var_250 = [];
            super();
            var_1243 = param1.readBoolean();
            var_1419 = param1.readInteger();
            var_884 = param1.readInteger();
            var_938 = param1.readInteger();
            var_1380 = param1.readInteger();
            var_1336 = param1.readInteger();
            var_1219 = param1.readInteger();
            var_891 = param1.readString();
            var_1407 = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_250.push(param1.readInteger());
                _loc3_++;
            }
        }
        private var var_1243: Boolean;
        private var var_1419: int;
        private var var_884: int;
        private var var_938: int;
        private var var_1380: int;
        private var var_1336: int;
        private var var_1219: int;
        private var var_891: String;
        private var var_1407: int;
        private var var_250: Array;

        public function get disposed(): Boolean {
            return var_250 == null;
        }

        public function get hasGoalExpired(): Boolean {
            return var_1243;
        }

        public function get personalContributionScore(): int {
            return var_1419;
        }

        public function get personalContributionRank(): int {
            return var_884;
        }

        public function get communityTotalScore(): int {
            return var_938;
        }

        public function get communityHighestAchievedLevel(): int {
            return var_1380;
        }

        public function get scoreRemainingUntilNextLevel(): int {
            return var_1336;
        }

        public function get percentCompletionTowardsNextLevel(): int {
            return var_1219;
        }

        public function get timeRemainingInSeconds(): int {
            return var_1407;
        }

        public function get rewardUserLimits(): Array {
            return var_250;
        }

        public function get goalCode(): String {
            return var_891;
        }

        public function dispose(): void {
            var_250 = null;
        }
    }
}
