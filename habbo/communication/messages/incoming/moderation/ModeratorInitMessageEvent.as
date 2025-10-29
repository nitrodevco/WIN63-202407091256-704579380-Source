package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.moderation.class_1553

    [SecureSWF(rename="true")]
    public class ModeratorInitMessageEvent extends MessageEvent implements IMessageEvent {

        public function ModeratorInitMessageEvent(param1: Function) {
            super(param1, class_1553);
        }

        public function getParser(): class_1553 {
            return _parser as class_1553;
        }
    }
}
