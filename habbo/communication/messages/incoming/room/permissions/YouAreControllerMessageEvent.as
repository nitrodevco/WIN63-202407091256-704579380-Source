package com.sulake.habbo.communication.messages.incoming.room.permissions {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.permissions.class_1250

    [SecureSWF(rename="true")]
    public class YouAreControllerMessageEvent extends MessageEvent {

        public function YouAreControllerMessageEvent(param1: Function) {
            super(param1, class_1250);
        }

        public function getParser(): class_1250 {
            return _parser as class_1250;
        }
    }
}
