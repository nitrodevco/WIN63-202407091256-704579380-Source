package com.sulake.habbo.communication.messages.parser.talent {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1771 {

        public static const const_325: String = "ACH_HabboWayGraduate1";

        public static const const_82: String = "ACH_GuideGroupMember1";

        public static const const_355: String = "ACH_SafetyQuizGraduate1";

        public static const const_261: String = "ACH_EmailVerification1";

        public static const ROOM_ENTRY_1: String = "ACH_RoomEntry1";

        public static const ROOM_ENTRY_2: String = "ACH_RoomEntry2";

        public static const const_385: String = "ACH_AvatarLooks1";

        public static const const_117: String = "ACH_GuideAdvertisementReader1";

        public function class_1771(param1: IMessageDataWrapper) {
            super();
            var_435 = param1.readInteger();
            var_432 = param1.readInteger();
            var_413 = param1.readString();
            var_149 = param1.readInteger();
            var_1353 = param1.readInteger();
            var_1256 = param1.readInteger();
        }
        private var var_435: int;
        private var var_432: int;
        private var var_413: String;
        private var var_149: int;
        private var var_1353: int;
        private var var_1256: int;

        public function get state(): int {
            return var_149;
        }

        public function get achievementId(): int {
            return var_435;
        }

        public function get requiredLevel(): int {
            return var_432;
        }

        public function get badgeCode(): String {
            return var_413;
        }

        public function get currentScore(): int {
            return var_1353;
        }

        public function get totalScore(): int {
            return var_1256;
        }

        public function hasProgressDisplay(): Boolean {
            switch (badgeCode) {
                case "ACH_HabboWayGraduate1":
                case "ACH_SafetyQuizGraduate1":
                case "ACH_EmailVerification1":
                case "ACH_AvatarLooks1":
                    break;
                default:
                    return true;
            }
            return false;
        }
    }
}
