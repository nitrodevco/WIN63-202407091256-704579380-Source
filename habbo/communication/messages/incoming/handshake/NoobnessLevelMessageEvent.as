package com.sulake.habbo.communication.messages.incoming.handshake {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.handshake.class_1458

    [SecureSWF(rename="true")]
    public class NoobnessLevelMessageEvent extends MessageEvent implements IMessageEvent {

        public function NoobnessLevelMessageEvent(param1: Function) {
            super(param1, class_1458);
        }

        public function get noobnessLevel(): int {
            return (this._parser as class_1458).noobnessLevel;
        }
    }
}
