package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.class_1409

    [SecureSWF(rename="true")]
    public class WiredErrorLogsEvent extends MessageEvent implements IMessageEvent {

        public function WiredErrorLogsEvent(param1: Function) {
            super(param1, class_1409);
        }

        public function getParser(): class_1409 {
            return this._parser as class_1409;
        }
    }
}
