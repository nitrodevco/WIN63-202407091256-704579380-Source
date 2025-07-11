package com.sulake.habbo.communication.messages.incoming.roomsettings {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1587

    [SecureSWF(rename="true")]
    public class class_1032 extends MessageEvent implements IMessageEvent {

        public function class_1032(param1: Function) {
            super(param1, class_1587);
        }

        public function getParser(): class_1587 {
            return this._parser as class_1587;
        }
    }
}
