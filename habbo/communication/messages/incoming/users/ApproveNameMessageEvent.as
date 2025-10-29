package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1328

    [SecureSWF(rename="true")]
    public class ApproveNameMessageEvent extends MessageEvent implements IMessageEvent {

        public function ApproveNameMessageEvent(param1: Function) {
            super(param1, class_1328);
        }

        public function getParser(): class_1328 {
            return _parser as class_1328;
        }
    }
}
