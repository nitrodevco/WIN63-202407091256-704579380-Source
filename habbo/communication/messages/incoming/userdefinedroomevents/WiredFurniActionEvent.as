package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1148

    [SecureSWF(rename="true")]
    public class WiredFurniActionEvent extends MessageEvent implements IMessageEvent {

        public function WiredFurniActionEvent(param1: Function) {
            super(param1, class_1148);
        }

        public function getParser(): class_1148 {
            return this._parser as class_1148;
        }
    }
}
