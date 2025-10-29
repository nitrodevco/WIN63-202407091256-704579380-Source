package com.sulake.habbo.communication.messages.incoming.vault {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.vault.class_1556

    [SecureSWF(rename="true")]
    public class IncomeRewardStatusMessageEvent extends MessageEvent implements IMessageEvent {

        public function IncomeRewardStatusMessageEvent(param1: Function) {
            super(param1, class_1556);
        }

        public function getParser(): class_1556 {
            return _parser as class_1556;
        }
    }
}
