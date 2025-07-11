package com.sulake.habbo.communication.messages.parser.error {
   import com.sulake.core.communication.messages.IMessageDataWrapper
   import com.sulake.core.communication.messages.IMessageParser

   [SecureSWF(rename="true")]
    public class class_1334 implements IMessageParser {

        public function class_1334() {
            super();
        }
        private var var_412: int;
        private var var_494: int;
        private var var_407: String;

        public function get errorCode(): int {
            return var_412;
        }

        public function get messageId(): int {
            return var_494;
        }

        public function get timestamp(): String {
            return var_407;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_494 = param1.readInteger();
            var_412 = param1.readInteger();
            var_407 = param1.readString();
            return true;
        }

        public function flush(): Boolean {
            var_412 = 0;
            var_494 = 0;
            var_407 = null;
            return true;
        }
    }
}
