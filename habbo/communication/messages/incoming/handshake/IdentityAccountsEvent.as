package com.sulake.habbo.communication.messages.incoming.handshake {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.handshake.class_1132

    [SecureSWF(rename="true")]
    public class IdentityAccountsEvent extends MessageEvent implements IMessageEvent {

        public function IdentityAccountsEvent(param1: Function) {
            super(param1, class_1132);
        }

        public function getParser(): class_1132 {
            return this._parser as class_1132;
        }
    }
}
