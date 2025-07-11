package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1230

    [SecureSWF(rename="true")]
    public class CallForHelpPendingCallsMessageEvent extends MessageEvent implements IMessageEvent {

        public function CallForHelpPendingCallsMessageEvent(param1: Function) {
            super(param1, class_1230);
        }

        public function getParser(): class_1230 {
            return _parser as class_1230;
        }
    }
}
