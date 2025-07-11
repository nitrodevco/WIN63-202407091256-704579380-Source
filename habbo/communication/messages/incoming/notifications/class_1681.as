package com.sulake.habbo.communication.messages.incoming.notifications {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1681 {

        public function class_1681(param1: IMessageDataWrapper) {
            super();
            var_329 = param1.readInteger();
            var_360 = param1.readInteger();
            var_372 = param1.readInteger();
            var_413 = param1.readString();
            var_682 = param1.readInteger();
            var_973 = param1.readInteger();
            var_1186 = param1.readInteger();
            var_1316 = param1.readInteger();
            var_1060 = param1.readInteger();
            var_963 = param1.readString();
            var_638 = param1.readString();
            var_926 = param1.readBoolean();
        }
        private var var_329: int;
        private var var_360: int;
        private var var_682: int;
        private var var_973: int;
        private var var_1186: int;
        private var var_1316: int;
        private var var_372: int;
        private var var_413: String = "";
        private var var_963: String = "";
        private var var_1060: int;
        private var var_638: String;
        private var var_926: Boolean;

        public function get type(): int {
            return var_329;
        }

        public function get level(): int {
            return var_360;
        }

        public function get points(): int {
            return var_682;
        }

        public function get levelRewardPoints(): int {
            return var_973;
        }

        public function get levelRewardPointType(): int {
            return var_1186;
        }

        public function get bonusPoints(): int {
            return var_1316;
        }

        public function get badgeId(): int {
            return var_372;
        }

        public function get badgeCode(): String {
            return var_413;
        }

        public function get removedBadgeCode(): String {
            return var_963;
        }

        public function get achievementID(): int {
            return var_1060;
        }

        public function get category(): String {
            return var_638;
        }

        public function get showDialogToUser(): Boolean {
            return var_926;
        }
    }
}
