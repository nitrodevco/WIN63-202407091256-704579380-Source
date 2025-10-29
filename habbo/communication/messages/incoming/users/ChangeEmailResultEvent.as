package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1351

    [SecureSWF(rename="true")]
    public class ChangeEmailResultEvent extends MessageEvent implements IMessageEvent {

        public function ChangeEmailResultEvent(param1: Function) {
            super(param1, class_1351);
        }

        public function getParser(): class_1351 {
            return _parser as class_1351;
        }
    }
}
