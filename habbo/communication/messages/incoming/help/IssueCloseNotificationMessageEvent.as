package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1478

    [SecureSWF(rename="true")]
    public class IssueCloseNotificationMessageEvent extends MessageEvent implements IMessageEvent {

        public function IssueCloseNotificationMessageEvent(param1: Function) {
            super(param1, class_1478);
        }

        public function getParser(): class_1478 {
            return _parser as class_1478;
        }
    }
}
