package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1297

    [SecureSWF(rename="true")]
    public class UserNameChangedMessageEvent extends MessageEvent implements IMessageEvent {

        public function UserNameChangedMessageEvent(param1: Function) {
            super(param1, class_1297);
        }

        public function getParser(): class_1297 {
            return _parser as class_1297;
        }
    }
}
