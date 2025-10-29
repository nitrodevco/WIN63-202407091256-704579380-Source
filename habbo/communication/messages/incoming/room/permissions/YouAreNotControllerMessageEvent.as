package com.sulake.habbo.communication.messages.incoming.room.permissions {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.permissions.class_1202

    [SecureSWF(rename="true")]
    public class YouAreNotControllerMessageEvent extends MessageEvent {

        public function YouAreNotControllerMessageEvent(param1: Function) {
            super(param1, class_1202);
        }

        public function getParser(): class_1202 {
            return _parser as class_1202;
        }
    }
}
