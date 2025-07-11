package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1767 {

        public function class_1767(param1: IMessageDataWrapper) {
            super();
            var_981 = param1.readString();
            var_554 = param1.readInteger();
        }
        private var var_981: String;
        private var var_554: int;

        public function get tagName(): String {
            return var_981;
        }

        public function get userCount(): int {
            return var_554;
        }
    }
}
