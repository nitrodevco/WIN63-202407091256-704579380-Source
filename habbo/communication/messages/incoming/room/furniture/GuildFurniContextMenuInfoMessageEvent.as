package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1236

    [SecureSWF(rename="true")]
    public class GuildFurniContextMenuInfoMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuildFurniContextMenuInfoMessageEvent(param1: Function) {
            super(param1, class_1236);
        }

        public function getParser(): class_1236 {
            return _parser as class_1236;
        }
    }
}
