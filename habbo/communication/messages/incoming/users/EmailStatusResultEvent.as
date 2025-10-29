package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1127

    [SecureSWF(rename="true")]
    public class EmailStatusResultEvent extends MessageEvent implements IMessageEvent {

        public function EmailStatusResultEvent(param1: Function) {
            super(param1, class_1127);
        }

        public function getParser(): class_1127 {
            return _parser as class_1127;
        }
    }
}
