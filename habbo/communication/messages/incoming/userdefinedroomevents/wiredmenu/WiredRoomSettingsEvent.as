package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.class_1257

    [SecureSWF(rename="true")]
    public class WiredRoomSettingsEvent extends MessageEvent implements IMessageEvent {

        public function WiredRoomSettingsEvent(param1: Function) {
            super(param1, class_1257);
        }

        public function getParser(): class_1257 {
            return this._parser as class_1257;
        }
    }
}
