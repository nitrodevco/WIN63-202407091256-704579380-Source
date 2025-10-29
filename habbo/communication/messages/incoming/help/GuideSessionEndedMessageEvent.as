package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1306

    [SecureSWF(rename="true")]
    public class GuideSessionEndedMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuideSessionEndedMessageEvent(param1: Function) {
            super(param1, class_1306);
        }

        public function getParser(): class_1306 {
            return _parser as class_1306;
        }
    }
}
