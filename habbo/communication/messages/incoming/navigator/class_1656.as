package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1656 {

        public function class_1656(param1: IMessageDataWrapper) {
            super();
            var_634 = param1.readInteger();
            var_1436 = param1.readString();
            var_848 = param1.readBoolean();
        }
        private var var_634: int;
        private var var_1436: String;
        private var var_848: Boolean;

        public function get categoryId(): int {
            return var_634;
        }

        public function get categoryName(): String {
            return var_1436;
        }

        public function get visible(): Boolean {
            return var_848;
        }
    }
}
