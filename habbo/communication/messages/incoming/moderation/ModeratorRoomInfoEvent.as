package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.moderation.class_1599

    [SecureSWF(rename="true")]
    public class ModeratorRoomInfoEvent extends MessageEvent implements IMessageEvent {

        public function ModeratorRoomInfoEvent(param1: Function) {
            super(param1, class_1599);
        }

        public function getParser(): class_1599 {
            return _parser as class_1599;
        }
    }
}
