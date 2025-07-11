package com.sulake.habbo.communication.messages.parser.talent {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1756 {

        public function class_1756(param1: IMessageDataWrapper) {
            super();
            var_865 = param1.readString();
        }
        private var var_865: String;

        public function get perkId(): String {
            return var_865;
        }
    }
}
