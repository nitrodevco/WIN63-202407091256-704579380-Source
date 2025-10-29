package com.sulake.habbo.communication.messages.incoming.vault {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.vault.class_1275

    [SecureSWF(rename="true")]
    public class IncomeRewardClaimResponseMessageEvent extends MessageEvent implements IMessageEvent {

        public function IncomeRewardClaimResponseMessageEvent(param1: Function) {
            super(param1, class_1275);
        }

        public function getParser(): class_1275 {
            return _parser as class_1275;
        }
    }
}
