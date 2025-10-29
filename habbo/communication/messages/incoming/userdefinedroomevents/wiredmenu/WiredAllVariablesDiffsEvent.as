package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.class_1286

    [SecureSWF(rename="true")]
    public class WiredAllVariablesDiffsEvent extends MessageEvent implements IMessageEvent {

        public function WiredAllVariablesDiffsEvent(param1: Function) {
            super(param1, class_1286);
        }

        public function getParser(): class_1286 {
            return this._parser as class_1286;
        }
    }
}
