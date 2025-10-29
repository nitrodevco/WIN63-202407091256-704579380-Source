package com.sulake.habbo.communication.messages.incoming.roomsettings {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1296

    [SecureSWF(rename="true")]
    public class RoomSettingsErrorEvent extends MessageEvent implements IMessageEvent {

        public function RoomSettingsErrorEvent(param1: Function) {
            super(param1, class_1296);
        }

        public function getParser(): class_1296 {
            return this._parser as class_1296;
        }
    }
}
