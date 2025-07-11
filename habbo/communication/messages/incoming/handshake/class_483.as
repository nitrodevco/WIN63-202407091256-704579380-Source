package com.sulake.habbo.communication.messages.incoming.handshake {
   import com.sulake.core.communication.messages.IMessageEvent
   import com.sulake.core.communication.messages.MessageEvent
   import com.sulake.habbo.communication.messages.parser.handshake.class_1156

   [SecureSWF(rename="true")]
    public class class_483 extends MessageEvent implements IMessageEvent {

        public function class_483(param1: Function) {
            super(param1, class_1156);
        }

        public function get suggestedLoginActions(): Array {
            return (this._parser as class_1156).suggestedLoginActions;
        }
    }
}
