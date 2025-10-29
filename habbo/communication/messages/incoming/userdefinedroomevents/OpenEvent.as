package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1150

    [SecureSWF(rename="true")]
    public class OpenEvent extends MessageEvent implements IMessageEvent {

        public function OpenEvent(param1: Function) {
            super(param1, class_1150);
        }

        public function getParser(): class_1150 {
            return this._parser as class_1150;
        }
    }
}
