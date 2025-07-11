package com.sulake.habbo.communication.messages.incoming.inventory.trading {
   import com.sulake.core.communication.messages.MessageEvent
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1119

   [SecureSWF(rename="true")]
    public class class_528 extends MessageEvent {

        public function class_528(param1: Function, param2: Class) {
            super(param1, param2);
        }

        public function get userID(): int {
            return getParser().userID;
        }

        public function getParser(): class_1119 {
            return _parser as class_1119;
        }
    }
}
