package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.moderation.class_1330

    [SecureSWF(rename="true")]
    public class ModeratorActionResultMessageEvent extends MessageEvent implements IMessageEvent {

        public function ModeratorActionResultMessageEvent(param1: Function) {
            super(param1, class_1330);
        }

        public function getParser(): class_1330 {
            return _parser as class_1330;
        }
    }
}
