package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1346

    [SecureSWF(rename="true")]
    public class CallForHelpResultMessageEvent extends MessageEvent implements IMessageEvent {

        public function CallForHelpResultMessageEvent(param1: Function) {
            super(param1, class_1346);
        }

        public function getParser(): class_1346 {
            return _parser as class_1346;
        }
    }
}
