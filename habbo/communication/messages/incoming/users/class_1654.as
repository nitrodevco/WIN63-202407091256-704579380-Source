package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1654 {

        public function class_1654(param1: IMessageDataWrapper) {
            super();
            var_1482 = param1.readInteger();
            var_1354 = param1.readInteger();
            var_810 = param1.readInteger();
        }
        private var var_1482: int;
        private var var_1354: int;
        private var var_810: int;

        public function get partId(): int {
            return var_1482;
        }

        public function get colorId(): int {
            return var_1354;
        }

        public function get position(): int {
            return var_810;
        }
    }
}
