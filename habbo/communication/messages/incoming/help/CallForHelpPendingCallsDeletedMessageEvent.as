package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1571

    [SecureSWF(rename="true")]
    public class CallForHelpPendingCallsDeletedMessageEvent extends MessageEvent implements IMessageEvent {

        public function CallForHelpPendingCallsDeletedMessageEvent(param1: Function) {
            super(param1, class_1571);
        }

        public function getParser(): class_1571 {
            return _parser as class_1571;
        }
    }
}
