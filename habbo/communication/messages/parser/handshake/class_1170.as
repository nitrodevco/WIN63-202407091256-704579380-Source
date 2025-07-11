package com.sulake.habbo.communication.messages.parser.handshake {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1170 implements IMessageParser {

        public function class_1170() {
            super();
        }
        private var var_838: String;
        private var var_790: String;

        public function get encryptedPrime(): String {
            return var_838;
        }

        public function get encryptedGenerator(): String {
            return var_790;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_838 = param1.readString();
            var_790 = param1.readString();
            return true;
        }
    }
}
