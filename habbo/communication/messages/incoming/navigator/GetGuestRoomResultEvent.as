package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.RoomSettingsDataEvent

    [SecureSWF(rename="true")]
    public class GetGuestRoomResultEvent extends MessageEvent implements IMessageEvent {

        public function GetGuestRoomResultEvent(param1: Function) {
            super(param1, RoomSettingsDataEvent);
        }

        public function getParser(): RoomSettingsDataEvent {
            return this._parser as RoomSettingsDataEvent;
        }
    }
}
