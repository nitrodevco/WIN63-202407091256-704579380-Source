package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1326

    [SecureSWF(rename="true")]
    public class UserUpdateMessageEvent extends MessageEvent {

        public function UserUpdateMessageEvent(param1: Function) {
            super(param1, class_1326);
        }

        public function getParser(): class_1326 {
            return _parser as class_1326;
        }
    }
}
