package com.sulake.habbo.communication.messages.incoming.room.chat {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.chat.class_1439

    [SecureSWF(rename="true")]
    public class RemainingMutePeriodEvent extends MessageEvent implements IMessageEvent {

        public function RemainingMutePeriodEvent(param1: Function) {
            super(param1, class_1439);
        }

        public function get secondsRemaining(): int {
            return class_1439(_parser).secondsRemaining;
        }
    }
}
