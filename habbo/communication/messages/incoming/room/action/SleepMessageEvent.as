package com.sulake.habbo.communication.messages.incoming.room.action {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.action.class_1386

    [SecureSWF(rename="true")]
    public class SleepMessageEvent extends MessageEvent {

        public function SleepMessageEvent(param1: Function) {
            super(param1, class_1386);
        }

        public function getParser(): class_1386 {
            return _parser as class_1386;
        }
    }
}
