package com.sulake.habbo.communication.messages.incoming.inventory.trading {
   import com.sulake.core.communication.messages.MessageEvent
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1252

   [SecureSWF(rename="true")]
    public class class_384 extends MessageEvent {

        public function class_384(param1: Function) {
            super(param1, class_1252);
        }

        public function getParser(): class_1252 {
            return _parser as class_1252;
        }
    }
}
