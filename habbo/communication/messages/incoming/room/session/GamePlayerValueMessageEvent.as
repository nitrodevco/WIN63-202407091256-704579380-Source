package com.sulake.habbo.communication.messages.incoming.room.session {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.session.class_1510

    [SecureSWF(rename="true")]
    public class GamePlayerValueMessageEvent extends MessageEvent {

        public function GamePlayerValueMessageEvent(param1: Function) {
            super(param1, class_1510);
        }

        public function getParser(): class_1510 {
            return _parser as class_1510;
        }
    }
}
