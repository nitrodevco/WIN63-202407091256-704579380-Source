package com.sulake.habbo.communication.messages.incoming.handshake {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.handshake.class_1338

    [SecureSWF(rename="true")]
    public class CompleteDiffieHandshakeEvent extends MessageEvent implements IMessageEvent {

        public function CompleteDiffieHandshakeEvent(param1: Function) {
            super(param1, class_1338);
        }

        public function get encryptedPublicKey(): String {
            return (this._parser as class_1338).encryptedPublicKey;
        }

        public function get serverClientEncryption(): Boolean {
            return (this._parser as class_1338).serverClientEncryption;
        }
    }
}
