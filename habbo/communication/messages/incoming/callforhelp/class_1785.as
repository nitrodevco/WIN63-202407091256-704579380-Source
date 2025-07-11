package com.sulake.habbo.communication.messages.incoming.callforhelp {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.communication.messages.incoming.moderation.class_1743

    [SecureSWF(rename="true")]
    public class class_1785 implements class_1743 {

        public function class_1785(param1: IMessageDataWrapper) {
            super();
            var_1443 = param1.readString();
            var_861 = param1.readInteger();
            var_1421 = param1.readString();
        }
        private var var_1443: String;
        private var var_861: int;
        private var var_1421: String;

        public function get name(): String {
            return var_1443;
        }

        public function get id(): int {
            return var_861;
        }

        public function get consequence(): String {
            return var_1421;
        }
    }
}
