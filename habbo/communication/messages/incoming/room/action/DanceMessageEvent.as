package com.sulake.habbo.communication.messages.incoming.room.action {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.action.class_1140

    [SecureSWF(rename="true")]
    public class DanceMessageEvent extends MessageEvent {

        public function DanceMessageEvent(param1: Function) {
            super(param1, class_1140);
        }

        public function getParser(): class_1140 {
            return _parser as class_1140;
        }
    }
}
