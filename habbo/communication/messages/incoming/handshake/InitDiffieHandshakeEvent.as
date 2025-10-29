package com.sulake.habbo.communication.messages.incoming.handshake {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.handshake.class_1170

    [SecureSWF(rename="true")]
    public class InitDiffieHandshakeEvent extends MessageEvent implements IMessageEvent {

        public function InitDiffieHandshakeEvent(param1: Function) {
            super(param1, class_1170);
        }

        public function get encryptedPrime(): String {
            return (this._parser as class_1170).encryptedPrime;
        }

        public function get encryptedGenerator(): String {
            return (this._parser as class_1170).encryptedGenerator;
        }
    }
}
