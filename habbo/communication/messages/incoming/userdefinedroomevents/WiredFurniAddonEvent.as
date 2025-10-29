package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1196

    [SecureSWF(rename="true")]
    public class WiredFurniAddonEvent extends MessageEvent implements IMessageEvent {

        public function WiredFurniAddonEvent(param1: Function) {
            super(param1, class_1196);
        }

        public function getParser(): class_1196 {
            return this._parser as class_1196;
        }
    }
}
