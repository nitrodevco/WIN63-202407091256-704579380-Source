package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1537

    [SecureSWF(rename="true")]
    public class ScrSendKickbackInfoMessageEvent extends MessageEvent implements IMessageEvent {

        public function ScrSendKickbackInfoMessageEvent(param1: Function) {
            super(param1, class_1537);
        }

        public function getParser(): class_1537 {
            return _parser as class_1537;
        }
    }
}
