package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1261

    [SecureSWF(rename="true")]
    public class GuideSessionAttachedMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuideSessionAttachedMessageEvent(param1: Function) {
            super(param1, class_1261);
        }

        public function getParser(): class_1261 {
            return _parser as class_1261;
        }
    }
}
