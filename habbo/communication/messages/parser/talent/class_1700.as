package com.sulake.habbo.communication.messages.parser.talent {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1700 {

        public function class_1700(param1: IMessageDataWrapper) {
            super();
            var_394 = param1.readString();
            var_1129 = param1.readInteger();
        }
        private var var_394: String;
        private var var_1129: int;

        public function get productCode(): String {
            return var_394;
        }

        public function get vipDays(): int {
            return var_1129;
        }
    }
}
