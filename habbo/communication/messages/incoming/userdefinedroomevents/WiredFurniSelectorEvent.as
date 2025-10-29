package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1209

    [SecureSWF(rename="true")]
    public class WiredFurniSelectorEvent extends MessageEvent implements IMessageEvent {

        public function WiredFurniSelectorEvent(param1: Function) {
            super(param1, class_1209);
        }

        public function getParser(): class_1209 {
            return this._parser as class_1209;
        }
    }
}
