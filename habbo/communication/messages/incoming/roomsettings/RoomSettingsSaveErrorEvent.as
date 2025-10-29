package com.sulake.habbo.communication.messages.incoming.roomsettings {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1204

    [SecureSWF(rename="true")]
    public class RoomSettingsSaveErrorEvent extends MessageEvent implements IMessageEvent {

        public function RoomSettingsSaveErrorEvent(param1: Function) {
            super(param1, class_1204);
        }

        public function getParser(): class_1204 {
            return this._parser as class_1204;
        }
    }
}
