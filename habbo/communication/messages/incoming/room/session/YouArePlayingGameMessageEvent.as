package com.sulake.habbo.communication.messages.incoming.room.session {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.session.class_1298

    [SecureSWF(rename="true")]
    public class YouArePlayingGameMessageEvent extends MessageEvent {

        public function YouArePlayingGameMessageEvent(param1: Function) {
            super(param1, class_1298);
        }

        public function getParser(): class_1298 {
            return _parser as class_1298;
        }
    }
}
