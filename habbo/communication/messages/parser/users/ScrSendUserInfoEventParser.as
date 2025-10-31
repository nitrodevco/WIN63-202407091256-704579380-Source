package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ScrSendUserInfoEventParser implements IMessageParser {

        public static const const_33: int = 1;

        public static const const_308: int = 2;

        public static const const_136: int = 3;

        public static const const_132: int = 4;

        public function ScrSendUserInfoEventParser() {
            super();
        }
        private var var_1109: int;

        private var var_1026: int;

        private var var_1087: int;

        private var var_1156: int;

        private var var_991: Boolean;

        private var var_1460: Boolean;

        private var var_808: int;

        private var var_1230: int;

        private var var_1476: int;

        private var var_1050: int;

        private var _productName: String;

        public function get productName(): String {
            return _productName;
        }

        public function get daysToPeriodEnd(): int {
            return var_1109;
        }

        public function get memberPeriods(): int {
            return var_1026;
        }

        public function get periodsSubscribedAhead(): int {
            return var_1087;
        }

        public function get responseType(): int {
            return var_1156;
        }

        public function get hasEverBeenMember(): Boolean {
            return var_991;
        }

        public function get isVIP(): Boolean {
            return var_1460;
        }

        public function get pastClubDays(): int {
            return var_808;
        }

        public function get pastVipDays(): int {
            return var_1230;
        }

        public function get minutesUntilExpiration(): int {
            return var_1476;
        }

        public function get minutesSinceLastModified(): int {
            return var_1050;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _productName = param1.readString();
            var_1109 = param1.readInteger();
            var_1026 = param1.readInteger();
            var_1087 = param1.readInteger();
            var_1156 = param1.readInteger();
            var_991 = param1.readBoolean();
            var_1460 = param1.readBoolean();
            var_808 = param1.readInteger();
            var_1230 = param1.readInteger();
            var_1476 = param1.readInteger();
            if (param1.bytesAvailable) {
                var_1050 = param1.readInteger();
            }
            return true;
        }
    }
}
