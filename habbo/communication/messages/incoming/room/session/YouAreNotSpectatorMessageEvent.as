package com.sulake.habbo.communication.messages.incoming.room.session {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.session.class_1524

    [SecureSWF(rename="true")]
    public class YouAreNotSpectatorMessageEvent extends MessageEvent {

        public function YouAreNotSpectatorMessageEvent(param1: Function) {
            super(param1, class_1524);
        }

        public function getParser(): class_1524 {
            return _parser as class_1524;
        }
    }
}
