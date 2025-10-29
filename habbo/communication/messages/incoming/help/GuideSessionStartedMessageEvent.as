package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1464

    [SecureSWF(rename="true")]
    public class GuideSessionStartedMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuideSessionStartedMessageEvent(param1: Function) {
            super(param1, class_1464);
        }

        public function getParser(): class_1464 {
            return _parser as class_1464;
        }
    }
}
