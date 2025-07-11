package com.sulake.habbo.communication.messages.incoming.inventory.achievements {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1724 {

        public static const const_109: int = -1;

        public static const const_263: int = 0;

        public static const const_408: int = 1;

        public static const const_163: int = 2;

        public function class_1724(param1: IMessageDataWrapper) {
            super();
            var_435 = param1.readInteger();
            var_360 = param1.readInteger();
            var_372 = param1.readString();
            var_532 = param1.readInteger();
            var_737 = Math.max(1, param1.readInteger());
            var_973 = param1.readInteger();
            var_1186 = param1.readInteger();
            var_572 = param1.readInteger();
            var_703 = param1.readBoolean();
            var_638 = param1.readString();
            var_1141 = param1.readString();
            var_986 = param1.readInteger();
            var_1409 = param1.readInteger();
            var_149 = param1.readShort();
        }
        private var var_435: int;
        private var var_360: int;
        private var var_372: String;
        private var var_532: int;
        private var var_737: int;
        private var var_973: int;
        private var var_1186: int;
        private var var_572: int;
        private var var_703: Boolean;
        private var var_638: String;
        private var var_1141: String;
        private var var_986: int;
        private var var_1409: int;
        private var var_149: int;

        public function get achievementId(): int {
            return var_435;
        }

        public function get badgeId(): String {
            return var_372;
        }

        public function get level(): int {
            return var_360;
        }

        public function get scoreAtStartOfLevel(): int {
            return var_532;
        }

        public function get scoreLimit(): int {
            return var_737 - var_532;
        }

        public function get levelRewardPoints(): int {
            return var_973;
        }

        public function get levelRewardPointType(): int {
            return var_1186;
        }

        public function get currentPoints(): int {
            return var_572 - var_532;
        }

        public function get finalLevel(): Boolean {
            return var_703;
        }

        public function get category(): String {
            return var_638;
        }

        public function get subCategory(): String {
            return var_1141;
        }

        public function get levelCount(): int {
            return var_986;
        }

        public function get state(): int {
            return var_149;
        }

        public function get firstLevelAchieved(): Boolean {
            return var_360 > 1 || var_703;
        }

        public function get displayMethod(): int {
            return var_1409;
        }

        public function setMaxProgress(): void {
            var_572 = var_737;
        }
    }
}
