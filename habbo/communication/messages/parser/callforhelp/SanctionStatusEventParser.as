package com.sulake.habbo.communication.messages.parser.callforhelp {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class SanctionStatusEventParser implements IMessageParser {

        public function SanctionStatusEventParser() {
            super();
        }
        private var var_855: Boolean;
        private var var_1048: Boolean;
        private var var_843: String;
        private var var_1415: int;
        private var var_935: String;
        private var var_872: String;
        private var var_1041: int;
        private var var_844: String;
        private var var_1310: int;
        private var var_1165: Boolean;
        private var var_1459: String;

        public function get isSanctionNew(): Boolean {
            return var_855;
        }

        public function get isSanctionActive(): Boolean {
            return var_1048;
        }

        public function get sanctionName(): String {
            return var_843;
        }

        public function get sanctionLengthHours(): int {
            return var_1415;
        }

        public function get sanctionReason(): String {
            return var_935;
        }

        public function get sanctionCreationTime(): String {
            return var_872;
        }

        public function get probationHoursLeft(): int {
            return var_1041;
        }

        public function get nextSanctionName(): String {
            return var_844;
        }

        public function get nextSanctionLengthHours(): int {
            return var_1310;
        }

        public function get hasCustomMute(): Boolean {
            return var_1165;
        }

        public function get tradeLockExpiryTime(): String {
            return var_1459;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_855 = param1.readBoolean();
            var_1048 = param1.readBoolean();
            var_843 = param1.readString();
            var_1415 = param1.readInteger();
            param1.readInteger();
            var_935 = param1.readString();
            var_872 = param1.readString();
            var_1041 = param1.readInteger();
            var_844 = param1.readString();
            var_1310 = param1.readInteger();
            param1.readInteger();
            var_1165 = param1.readBoolean();
            if (param1.bytesAvailable) {
                var_1459 = param1.readString();
            }
            return true;
        }
    }
}
