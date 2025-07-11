package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1670 {

        public function class_1670(param1: IMessageDataWrapper) {
            super();
            var_418 = param1.readInteger();
            _userName = param1.readString();
            var_426 = param1.readString();
            var_1122 = param1.readInteger();
            var_1252 = param1.readInteger();
            var_1106 = param1.readBoolean();
            var_809 = param1.readInteger();
            var_1247 = param1.readInteger();
            var_949 = param1.readInteger();
            var_1192 = param1.readInteger();
            var_987 = param1.readInteger();
            var_766 = param1.readString();
            var_983 = param1.readString();
            var_520 = param1.readInteger();
            var_1090 = param1.readInteger();
            var_1474 = param1.readString();
            var_1260 = param1.readString();
            if (param1.bytesAvailable) {
                var_1508 = param1.readString();
                var_1072 = param1.readInteger();
            }
        }
        private var var_418: int;
        private var var_1122: int;

        private var var_1252: int;

        private var var_1106: Boolean;

        private var var_809: int;

        private var var_1247: int;

        private var var_949: int;

        private var var_1192: int;

        private var var_987: int;

        private var var_766: String;

        private var var_983: String;

        private var var_520: int;

        private var var_1090: int;

        private var var_1474: String;

        private var var_426: String;

        private var var_1260: String;

        private var var_1508: String = "";

        private var var_1072: int = 0;

        private var _userName: String;

        public function get userName(): String {
            return _userName;
        }

        public function get userId(): int {
            return var_418;
        }

        public function get figure(): String {
            return var_426;
        }

        public function get registrationAgeInMinutes(): int {
            return var_1122;
        }

        public function get minutesSinceLastLogin(): int {
            return var_1252;
        }

        public function get online(): Boolean {
            return var_1106;
        }

        public function get cfhCount(): int {
            return var_809;
        }

        public function get abusiveCfhCount(): int {
            return var_1247;
        }

        public function get cautionCount(): int {
            return var_949;
        }

        public function get banCount(): int {
            return var_1192;
        }

        public function get tradingLockCount(): int {
            return var_987;
        }

        public function get tradingExpiryDate(): String {
            return var_766;
        }

        public function get lastPurchaseDate(): String {
            return var_983;
        }

        public function get identityId(): int {
            return var_520;
        }

        public function get identityRelatedBanCount(): int {
            return var_1090;
        }

        public function get primaryEmailAddress(): String {
            return var_1474;
        }

        public function get userClassification(): String {
            return var_1260;
        }

        public function get lastSanctionTime(): String {
            return var_1508;
        }

        public function get sanctionAgeHours(): int {
            return var_1072;
        }
    }
}
