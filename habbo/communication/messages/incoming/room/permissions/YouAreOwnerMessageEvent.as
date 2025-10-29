package com.sulake.habbo.communication.messages.incoming.room.permissions {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.permissions.class_1574

    [SecureSWF(rename="true")]
    public class YouAreOwnerMessageEvent extends MessageEvent {

        public function YouAreOwnerMessageEvent(param1: Function) {
            super(param1, class_1574);
        }

        public function getParser(): class_1574 {
            return _parser as class_1574;
        }
    }
}
