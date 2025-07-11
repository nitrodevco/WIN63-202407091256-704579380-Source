package com.sulake.habbo.communication.messages.incoming.roomsettings {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1514

    [SecureSWF(rename="true")]
    public class class_540 extends MessageEvent implements IMessageEvent {

        public function class_540(param1: Function) {
            super(param1, class_1514);
        }

        public function getParser(): class_1514 {
            return this._parser as class_1514;
        }
    }
}
