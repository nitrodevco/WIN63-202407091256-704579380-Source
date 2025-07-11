package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.class_1577

    [SecureSWF(rename="true")]
    public class class_158 extends MessageEvent implements IMessageEvent {

        public function class_158(param1: Function) {
            super(param1, class_1577);
        }

        public function getParser(): class_1577 {
            return this._parser as class_1577;
        }
    }
}
