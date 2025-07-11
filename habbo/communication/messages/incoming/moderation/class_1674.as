package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1674 {

        public function class_1674(param1: IMessageDataWrapper) {
            super();
            var_1307 = param1.readInteger();
            var_1328 = param1.readInteger();
            var_874 = param1.readInteger();
            var_1211 = param1.readInteger();
            var_506 = new class_1757(param1);
        }
        private var var_1307: int;
        private var var_1328: int;
        private var var_874: int;
        private var var_1211: int;
        private var var_506: class_1757;

        public function get callId(): int {
            return var_1307;
        }

        public function get callerUserId(): int {
            return var_1328;
        }

        public function get reportedUserId(): int {
            return var_874;
        }

        public function get chatRecordId(): int {
            return var_1211;
        }

        public function get chatRecord(): class_1757 {
            return var_506;
        }
    }
}
