package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1289

    [SecureSWF(rename="true")]
    public class GuideSessionErrorMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuideSessionErrorMessageEvent(param1: Function) {
            super(param1, class_1289);
        }

        public function getParser(): class_1289 {
            return _parser as class_1289;
        }
    }
}
