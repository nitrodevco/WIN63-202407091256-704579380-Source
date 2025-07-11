package com.sulake.habbo.communication.messages.incoming.handshake {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.handshake.class_1267

    [SecureSWF(rename="true")]
    public class class_556 extends MessageEvent implements IMessageEvent {

        public function class_556(param1: Function) {
            super(param1, class_1267);
        }

        public function getParser(): class_1267 {
            return this._parser as class_1267;
        }
    }
}
