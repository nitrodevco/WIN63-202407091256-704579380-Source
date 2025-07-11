package com.sulake.habbo.communication.messages.incoming.quest {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1715 {

        public static function getCampaignLocalizationKeyForCode(param1: String): String {
            return "quests." + param1;
        }

        public function class_1715(param1: IMessageDataWrapper) {
            var_475 = new Date();
            super();
            var_556 = param1.readString();
            var_714 = param1.readInteger();
            var_681 = param1.readInteger();
            var_452 = param1.readInteger();
            var_280 = param1.readInteger();
            var_570 = param1.readBoolean();
            var_329 = param1.readString();
            var_1438 = param1.readString();
            var_788 = param1.readInteger();
            var_705 = param1.readString();
            var_663 = param1.readInteger();
            var_702 = param1.readInteger();
            var_1025 = param1.readInteger();
            _catalogPageName = param1.readString();
            var_687 = param1.readString();
            var_1332 = param1.readBoolean();
            var_571 = param1.readBoolean();
            if (var_571) {
                var_662 = param1.readInteger();
            }
        }
        private var var_556: String;
        private var var_714: int;
        private var var_681: int;
        private var var_452: int;
        private var var_280: int;
        private var var_570: Boolean;
        private var var_329: String;
        private var var_1438: String;
        private var var_788: int;
        private var var_705: String;
        private var var_663: int;
        private var var_702: int;
        private var var_708: int;
        private var var_1025: int;
        private var var_687: String;
        private var var_1332: Boolean;
        private var var_571: Boolean;
        private var var_662: int;
        private var var_475: Date;

        private var _catalogPageName: String;

        public function get catalogPageName(): String {
            return _catalogPageName;
        }

        public function get campaignCode(): String {
            return var_556;
        }

        public function get localizationCode(): String {
            return var_705;
        }

        public function get completedQuestsInCampaign(): int {
            return var_714;
        }

        public function get questCountInCampaign(): int {
            return var_681;
        }

        public function get activityPointType(): int {
            return var_452;
        }

        public function get accepted(): Boolean {
            return var_570;
        }

        public function set accepted(param1: Boolean): void {
            var_570 = param1;
        }

        public function get id(): int {
            return var_280;
        }

        public function set id(param1: int): void {
            var_280 = param1;
        }

        public function get type(): String {
            return var_329;
        }

        public function get imageVersion(): String {
            return var_1438;
        }

        public function get rewardCurrencyAmount(): int {
            return var_788;
        }

        public function get completedSteps(): int {
            return var_663;
        }

        public function get totalSteps(): int {
            return var_702;
        }

        public function get isCompleted(): Boolean {
            return var_663 == var_702;
        }

        public function get waitPeriodSeconds(): int {
            if (var_708 < 1) {
                return 0;
            }
            var _loc1_: Date = new Date();
            var _loc2_: int = _loc1_.getTime() - var_475.getTime();
            return int(Math.max(0, var_708 - Math.floor(_loc2_ / 1000)));
        }

        public function set waitPeriodSeconds(param1: int): void {
            var_708 = param1;
        }

        public function get isSeasonal(): Boolean {
            return var_571;
        }

        public function get secondsLeft(): int {
            if (var_662 <= 0) {
                return 0;
            }
            var _loc1_: Date = new Date();
            var _loc2_: int = (_loc1_.getTime() - var_475.getTime()) / 1000;
            return var_662 - _loc2_;
        }

        public function get completedCampaign(): Boolean {
            return var_280 < 1;
        }

        public function get lastQuestInCampaign(): Boolean {
            return var_714 >= var_681;
        }

        public function get receiveTime(): Date {
            return var_475;
        }

        public function get sortOrder(): int {
            return var_1025;
        }

        public function get chainCode(): String {
            return var_687;
        }

        public function get campaignChainCode(): String {
            if (var_571) {
                return var_556 + "." + var_687;
            }
            return var_556;
        }

        public function get easy(): Boolean {
            return var_1332;
        }

        public function getCampaignLocalizationKey(): String {
            return getCampaignLocalizationKeyForCode(campaignCode);
        }

        public function getQuestLocalizationKey(): String {
            return this.getCampaignLocalizationKey() + "." + var_705;
        }
    }
}
