package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1444

    [SecureSWF(rename="true")]
    public class WiredFurniVariableEvent extends MessageEvent implements IMessageEvent {

        public function WiredFurniVariableEvent(param1: Function) {
            super(param1, class_1444);
        }

        public function getParser(): class_1444 {
            return this._parser as class_1444;
        }
    }
}
