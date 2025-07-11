package com.sulake.habbo.communication.messages.incoming.roomsettings {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1429

    [SecureSWF(rename="true")]
    public class class_923 extends MessageEvent implements IMessageEvent {

        public function class_923(param1: Function) {
            super(param1, class_1429);
        }

        public function getParser(): class_1429 {
            return this._parser as class_1429;
        }
    }
}
