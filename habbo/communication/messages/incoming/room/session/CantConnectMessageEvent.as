package com.sulake.habbo.communication.messages.incoming.room.session {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.session.class_1428

    [SecureSWF(rename="true")]
    public class CantConnectMessageEvent extends MessageEvent {

        public function CantConnectMessageEvent(param1: Function) {
            super(param1, class_1428);
        }

        public function getParser(): class_1428 {
            return _parser as class_1428;
        }
    }
}
