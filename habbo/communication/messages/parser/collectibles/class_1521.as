package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1521 implements IMessageParser {

        public function class_1521() {
            super();
        }
        private var var_1161: String;
        private var var_904: String;
        private var var_258: Boolean;

        public function get collectionId(): String {
            return var_1161;
        }

        public function get walletAddress(): String {
            return var_904;
        }

        public function get success(): Boolean {
            return var_258;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1161 = param1.readString();
            var_904 = param1.readString();
            var_258 = param1.readBoolean();
            return true;
        }
    }
}
