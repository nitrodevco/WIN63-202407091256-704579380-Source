package com.sulake.habbo.communication.messages.incoming.friendlist {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.friendlist.class_1187

    [SecureSWF(rename="true")]
    public class RoomInviteEvent extends MessageEvent implements IMessageEvent {

        public function RoomInviteEvent(param1: Function) {
            super(param1, class_1187);
        }

        public function getParser(): class_1187 {
            return this._parser as class_1187;
        }
    }
}
