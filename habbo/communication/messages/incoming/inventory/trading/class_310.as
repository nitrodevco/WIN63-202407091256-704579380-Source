package com.sulake.habbo.communication.messages.incoming.inventory.trading {
   import com.sulake.core.communication.messages.MessageEvent
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1504

   [SecureSWF(rename="true")]
    public class class_310 extends MessageEvent {

        public function class_310(param1: Function, param2: Class) {
            super(param1, param2);
        }

        public function get userID(): int {
            return getParser().userID;
        }

        public function get userAccepts(): Boolean {
            return getParser().userAccepts;
        }

        public function getParser(): class_1504 {
            return _parser as class_1504;
        }
    }
}
