package com.sulake.habbo.communication.messages.outgoing.handshake {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.communication.messages.IPreEncryptionMessage

   [SecureSWF(rename="true")]
    public class CompleteDiffieHandshakeMessageComposer implements IMessageComposer, IPreEncryptionMessage {

        public function CompleteDiffieHandshakeMessageComposer(param1: String) {
            super();
            _publicKey = param1;
        }
        private var _publicKey: String;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [_publicKey];
        }
    }
}
