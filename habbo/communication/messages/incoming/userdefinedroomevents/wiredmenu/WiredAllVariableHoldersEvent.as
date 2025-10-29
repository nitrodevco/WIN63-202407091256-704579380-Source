package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.class_1165

    [SecureSWF(rename="true")]
    public class WiredAllVariableHoldersEvent extends MessageEvent implements IMessageEvent {

        public function WiredAllVariableHoldersEvent(param1: Function) {
            super(param1, class_1165);
        }

        public function getParser(): class_1165 {
            return this._parser as class_1165;
        }
    }
}
