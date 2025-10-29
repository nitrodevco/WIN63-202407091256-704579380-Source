package com.sulake.habbo.communication.messages.incoming.handshake {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.handshake.class_1366

    [SecureSWF(rename="true")]
    public class GenericErrorEvent extends MessageEvent implements IMessageEvent {

        public function GenericErrorEvent(param1: Function) {
            super(param1, class_1366);
        }

        public function getParser(): class_1366 {
            return this._parser as class_1366;
        }
    }
}
