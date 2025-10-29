package com.sulake.habbo.communication.messages.incoming.roomsettings {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1120

    [SecureSWF(rename="true")]
    public class RoomSettingsDataEvent extends MessageEvent implements IMessageEvent {

        public function RoomSettingsDataEvent(param1: Function) {
            super(param1, class_1120);
        }

        public function getParser(): class_1120 {
            return this._parser as class_1120;
        }
    }
}
