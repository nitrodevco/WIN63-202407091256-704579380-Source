package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1262

    [SecureSWF(rename="true")]
    public class CallForHelpDisabledNotifyMessageEvent extends MessageEvent implements IMessageEvent {

        public function CallForHelpDisabledNotifyMessageEvent(param1: Function) {
            super(param1, class_1262);
        }

        public function getParser(): class_1262 {
            return _parser as class_1262;
        }
    }
}
