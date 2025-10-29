package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1628

    [SecureSWF(rename="true")]
    public class WiredValidationErrorEvent extends MessageEvent implements IMessageEvent {

        public function WiredValidationErrorEvent(param1: Function) {
            super(param1, class_1628);
        }

        public function getParser(): class_1628 {
            return this._parser as class_1628;
        }
    }
}
