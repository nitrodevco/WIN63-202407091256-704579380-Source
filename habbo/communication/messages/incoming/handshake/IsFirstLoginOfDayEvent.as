package com.sulake.habbo.communication.messages.incoming.handshake {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.handshake.class_1142

    [SecureSWF(rename="true")]
    public class IsFirstLoginOfDayEvent extends MessageEvent implements IMessageEvent {

        public function IsFirstLoginOfDayEvent(param1: Function) {
            super(param1, class_1142);
        }

        public function getParser(): class_1142 {
            return this._parser as class_1142;
        }
    }
}
