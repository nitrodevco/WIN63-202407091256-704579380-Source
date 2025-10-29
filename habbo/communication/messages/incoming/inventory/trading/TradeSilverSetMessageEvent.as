package com.sulake.habbo.communication.messages.incoming.inventory.trading {
   import com.sulake.core.communication.messages.MessageEvent
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1604

   [SecureSWF(rename="true")]
    public class TradeSilverSetMessageEvent extends MessageEvent {

        public function TradeSilverSetMessageEvent(param1: Function) {
            super(param1, class_1604);
        }

        public function getParser(): class_1604 {
            return _parser as class_1604;
        }
    }
}
