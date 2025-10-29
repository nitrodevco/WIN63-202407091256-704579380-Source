package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1259

    [SecureSWF(rename="true")]
    public class GuideOnDutyStatusMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuideOnDutyStatusMessageEvent(param1: Function) {
            super(param1, class_1259);
        }

        public function getParser(): class_1259 {
            return _parser as class_1259;
        }
    }
}
