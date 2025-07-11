package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1692 {

        public static var var_1616: int = 0;

        public static var var_1624: int = 1;

        public static var var_1621: int = 2;

        public static var var_232: int = 0;

        public static var var_858: int = 1;

        public function class_1692(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            var _loc2_: class_1786 = null;
            var_138 = var_232;
            var_137 = var_232;
            super();
            var _loc6_: int = param1.readInteger();
            _items = [];
            var_289 = 0;
            _loc3_ = 0;
            while (_loc3_ < _loc6_) {
                _loc2_ = new class_1786(param1);
                _items.push(_loc2_);
                if (_loc2_.amount > 0) {
                    var_289 += 1;
                }
                _loc3_++;
            }
            var_1161 = param1.readString();
            var_1450 = param1.readString();
            var_827 = param1.readInteger();
            var_1167 = param1.readInteger();
            var_1493 = param1.readInteger();
            var _loc4_: Boolean;
            if (_loc4_ = param1.readBoolean()) {
                var_747 = new class_1786(param1);
            }
            var _loc5_: Boolean;
            if (_loc5_ = param1.readBoolean()) {
                var_668 = new class_1786(param1);
            }
            var_1339 = param1.readLong();
            var_750 = param1.readLong();
            _status = param1.readShort();
            if (_loc4_) {
                var_98 = new CollectibleItemClaim(param1);
            }
            if (_loc5_) {
                var_91 = new CollectibleItemClaim(param1);
            }
        }
        private var var_1161: String;

        private var var_1450: String;

        private var var_827: int;

        private var var_1167: int;

        private var var_1493: int;

        private var var_747: class_1786;

        private var var_668: class_1786;

        private var var_1339: Number;

        private var var_750: Number;
        private var var_98: CollectibleItemClaim;
        private var var_91: CollectibleItemClaim;
        private var var_289: int;
        private var var_138: int;
        private var var_137: int;

        private var _items: Array;

        public function get items(): Array {
            return _items;
        }

        private var _status: int;

        public function get status(): int {
            return _status;
        }

        public function get collectionId(): String {
            return var_1161;
        }

        public function get collectionName(): String {
            return var_1450;
        }

        public function get collectionScore(): int {
            return var_827;
        }

        public function get collectionTotalScore(): int {
            return var_1167;
        }

        public function get collectionBoostScore(): int {
            return var_1493;
        }

        public function get bonusItem(): class_1786 {
            return var_747;
        }

        public function get rewardItem(): class_1786 {
            return var_668;
        }

        public function get releasedTime(): Number {
            return var_1339;
        }

        public function get snapshotTime(): Number {
            return var_750;
        }

        public function get bonusItemClaim(): CollectibleItemClaim {
            return var_98;
        }

        public function get rewardItemClaim(): CollectibleItemClaim {
            return var_91;
        }

        public function get collectedItemCount(): int {
            return var_289;
        }

        public function get totalItemCount(): int {
            return _items.length;
        }

        public function get claimingBonusStatus(): int {
            return var_138;
        }

        public function get claimingRewardStatus(): int {
            return var_137;
        }

        public function get hasRewardItem(): Boolean {
            return var_668 != null;
        }

        public function get hasBonusItem(): Boolean {
            return var_747 != null;
        }

        public function get rewardClaimed(): Boolean {
            return hasRewardItem && var_91 != null && (var_91.claimedAmount > 0 && var_91.claimedAmount >= var_91.claimLimit || var_137 == class_1692.var_858);
        }

        public function get bonusClaimed(): Boolean {
            return hasBonusItem && var_98 != null && (var_98.claimedAmount > 0 && var_98.claimedAmount >= var_98.claimLimit || var_138 != class_1692.var_232);
        }

        public function get canClaimReward(): Boolean {
            return hasRewardItem && var_91 != null && var_91.status == CollectibleItemClaim.var_1523 && !rewardClaimed && var_91.claimedAmount < var_91.claimLimit && var_137 == class_1692.var_232;
        }

        public function get canClaimBonus(): Boolean {
            return hasBonusItem && var_98 != null && var_98.status == CollectibleItemClaim.var_1523 && !bonusClaimed && var_98.claimedAmount < var_98.claimLimit && var_138 == class_1692.var_232;
        }

        public function claimRewardAwaiting(): void {
            var_137 = var_858;
        }

        public function claimBonusAwaiting(): void {
            var_138 = var_858;
        }

        public function claimRewardFinished(param1: Boolean): void {
            var_137 = var_232;
            if (param1) {
                rewardItemClaim.claimedAmount += 1;
            }
        }

        public function claimBonusFinished(param1: Boolean): void {
            var_138 = var_232;
            if (param1) {
                bonusItemClaim.claimedAmount += 1;
            }
        }

        public function isBonusSnapshotPassed(): Boolean {
            return var_750 < new Date().time;
        }
    }
}
