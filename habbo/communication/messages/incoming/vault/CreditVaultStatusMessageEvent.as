package com.sulake.habbo.communication.messages.incoming.vault {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.vault.class_1463

    [SecureSWF(rename="true")]
    public class CreditVaultStatusMessageEvent extends MessageEvent implements IMessageEvent {

        public function CreditVaultStatusMessageEvent(param1: Function) {
            super(param1, class_1463);
        }

        public function getParser(): class_1463 {
            return _parser as class_1463;
        }
    }
}
