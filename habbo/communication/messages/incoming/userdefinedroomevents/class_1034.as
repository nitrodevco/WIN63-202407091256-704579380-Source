package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1311

    [SecureSWF(rename="true")]
    public class class_1034 extends MessageEvent implements IMessageEvent {

        public function class_1034(param1: Function) {
            super(param1, class_1311);
        }

        public function getParser(): class_1311 {
            return this._parser as class_1311;
        }
    }
}
