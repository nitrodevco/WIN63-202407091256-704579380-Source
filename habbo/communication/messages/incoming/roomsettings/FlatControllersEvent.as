package com.sulake.habbo.communication.messages.incoming.roomsettings {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1185

    [SecureSWF(rename="true")]
    public class FlatControllersEvent extends MessageEvent implements IMessageEvent {

        public function FlatControllersEvent(param1: Function) {
            super(param1, class_1185);
        }

        public function getParser(): class_1185 {
            return this._parser as class_1185;
        }
    }
}
