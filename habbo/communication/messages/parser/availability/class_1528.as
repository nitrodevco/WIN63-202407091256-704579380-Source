package com.sulake.habbo.communication.messages.parser.availability {
   import com.sulake.core.communication.messages.IMessageDataWrapper
   import com.sulake.core.communication.messages.IMessageParser

   [SecureSWF(rename="true")]
    public class class_1528 implements IMessageParser {

        public function class_1528() {
            super();
        }
        private var var_498: int;
        private var var_585: int;

        public function get openHour(): int {
            return var_498;
        }

        public function get openMinute(): int {
            return var_585;
        }

        public function flush(): Boolean {
            var_498 = 0;
            var_585 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_498 = param1.readInteger();
            var_585 = param1.readInteger();
            return true;
        }
    }
}
