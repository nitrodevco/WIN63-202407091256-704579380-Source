package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.moderation.class_1254

    [SecureSWF(rename="true")]
    public class CfhChatlogEvent extends MessageEvent implements IMessageEvent {

        public function CfhChatlogEvent(param1: Function) {
            super(param1, class_1254);
        }

        public function getParser(): class_1254 {
            return _parser as class_1254;
        }
    }
}
