package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1513

    [SecureSWF(rename="true")]
    public class WiredSaveSuccessEvent extends MessageEvent implements IMessageEvent {

        public function WiredSaveSuccessEvent(param1: Function) {
            super(param1, class_1513);
        }

        public function getParser(): class_1513 {
            return this._parser as class_1513;
        }
    }
}
