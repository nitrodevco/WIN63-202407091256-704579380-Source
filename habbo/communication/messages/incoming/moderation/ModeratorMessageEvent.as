package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.moderation.class_1324

    [SecureSWF(rename="true")]
    public class ModeratorMessageEvent extends MessageEvent implements IMessageEvent {

        public function ModeratorMessageEvent(param1: Function) {
            super(param1, class_1324);
        }

        public function getParser(): class_1324 {
            return _parser as class_1324;
        }
    }
}
