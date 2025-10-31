package com.sulake.habbo.communication.messages.parser.handshake {
   import com.sulake.core.communication.messages.IMessageDataWrapper
   import com.sulake.core.communication.messages.IMessageParser

   [SecureSWF(rename="true")]
    public class GenericErrorEventParser implements IMessageParser {

        public function GenericErrorEventParser() {
            super();
        }
        private var var_412: int;

        public function get errorCode(): int {
            return var_412;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_412 = param1.readInteger();
            return true;
        }
    }
}
