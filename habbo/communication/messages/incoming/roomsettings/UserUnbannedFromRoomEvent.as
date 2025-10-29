package com.sulake.habbo.communication.messages.incoming.roomsettings {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1417

    [SecureSWF(rename="true")]
    public class UserUnbannedFromRoomEvent extends MessageEvent implements IMessageEvent {

        public function UserUnbannedFromRoomEvent(param1: Function) {
            super(param1, class_1417);
        }

        public function getParser(): class_1417 {
            return this._parser as class_1417;
        }
    }
}
