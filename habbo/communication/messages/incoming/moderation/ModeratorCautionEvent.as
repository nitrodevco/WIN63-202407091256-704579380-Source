package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.moderation.class_1578

    [SecureSWF(rename="true")]
    public class ModeratorCautionEvent extends MessageEvent implements IMessageEvent {

        public function ModeratorCautionEvent(param1: Function) {
            super(param1, class_1578);
        }

        public function getParser(): class_1578 {
            return _parser as class_1578;
        }
    }
}
