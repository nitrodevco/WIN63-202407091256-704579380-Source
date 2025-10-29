package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1357

    [SecureSWF(rename="true")]
    public class PetSupplementedNotificationEvent extends MessageEvent implements IMessageEvent {

        public function PetSupplementedNotificationEvent(param1: Function) {
            super(param1, class_1357);
        }

        public function getParser(): class_1357 {
            return _parser as class_1357;
        }
    }
}
