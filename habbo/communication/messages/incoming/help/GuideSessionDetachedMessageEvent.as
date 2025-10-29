package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1560

    [SecureSWF(rename="true")]
    public class GuideSessionDetachedMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuideSessionDetachedMessageEvent(param1: Function) {
            super(param1, class_1560);
        }

        public function getParser(): class_1560 {
            return _parser as class_1560;
        }
    }
}
