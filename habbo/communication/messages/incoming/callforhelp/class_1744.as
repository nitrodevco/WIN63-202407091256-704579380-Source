package com.sulake.habbo.communication.messages.incoming.callforhelp {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.communication.messages.incoming.moderation.class_1743

    [SecureSWF(rename="true")]
    public class class_1744 implements class_1743 {

        public function class_1744(param1: IMessageDataWrapper) {
            super();
            _name = param1.readString();
            var_1416 = param1.readInteger();
            var_1522 = param1.readInteger();
            var_1472 = param1.readBoolean();
            if (param1.bytesAvailable) {
                var_1246 = param1.readString();
            }
            if (param1.bytesAvailable) {
                var_1032 = param1.readString();
            }
        }
        private var var_1416: int;

        private var var_1522: int;

        private var var_1472: Boolean;

        private var var_1246: String = "";

        private var var_1032: String = "";

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        public function get sanctionLengthInHours(): int {
            return var_1416;
        }

        public function get avatarOnly(): Boolean {
            return var_1472;
        }

        public function get tradeLockInfo(): String {
            return var_1246;
        }

        public function get machineBanInfo(): String {
            return var_1032;
        }
    }
}
