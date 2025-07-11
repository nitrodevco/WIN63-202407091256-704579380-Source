package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.class_1284

    [SecureSWF(rename="true")]
    public class class_877 extends MessageEvent implements IMessageEvent {

        public function class_877(param1: Function) {
            super(param1, class_1284);
        }

        public function getParser(): class_1284 {
            return this._parser as class_1284;
        }
    }
}
