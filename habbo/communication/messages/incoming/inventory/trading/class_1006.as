package com.sulake.habbo.communication.messages.incoming.inventory.trading {
   import com.sulake.core.communication.messages.MessageEvent
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1420

   [SecureSWF(rename="true")]
    public class class_1006 extends MessageEvent {

        public function class_1006(param1: Function, param2: Class) {
            super(param1, param2);
        }

        public function get userID(): int {
            return getParser().userID;
        }

        public function get userCanTrade(): Boolean {
            return getParser().userCanTrade;
        }

        public function get otherUserID(): int {
            return getParser().otherUserID;
        }

        public function get otherUserCanTrade(): Boolean {
            return getParser().otherUserCanTrade;
        }

        public function getParser(): class_1420 {
            return _parser as class_1420;
        }
    }
}
