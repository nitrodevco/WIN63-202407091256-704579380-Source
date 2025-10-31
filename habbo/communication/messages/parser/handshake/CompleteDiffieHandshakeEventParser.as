package com.sulake.habbo.communication.messages.parser.handshake {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CompleteDiffieHandshakeEventParser implements IMessageParser {

        public function CompleteDiffieHandshakeEventParser() {
            super();
        }
        private var var_1244: String;
        private var var_1374: Boolean = false;

        public function get encryptedPublicKey(): String {
            return var_1244;
        }

        public function get serverClientEncryption(): Boolean {
            return var_1374;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1244 = param1.readString();
            if (param1.bytesAvailable) {
                var_1374 = param1.readBoolean();
            }
            return true;
        }
    }
}
