package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.class_1122

    [SecureSWF(rename="true")]
    public class class_442 extends MessageEvent implements IMessageEvent {

        public function class_442(param1: Function) {
            super(param1, class_1122);
        }

        public function getParser(): class_1122 {
            return this._parser as class_1122;
        }
    }
}
