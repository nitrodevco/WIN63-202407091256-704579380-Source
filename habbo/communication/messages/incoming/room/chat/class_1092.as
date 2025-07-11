package com.sulake.habbo.communication.messages.incoming.room.chat {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.chat.class_1439

    [SecureSWF(rename="true")]
    public class class_1092 extends MessageEvent implements IMessageEvent {

        public function class_1092(param1: Function) {
            super(param1, class_1439);
        }

        public function get secondsRemaining(): int {
            return class_1439(_parser).secondsRemaining;
        }
    }
}
