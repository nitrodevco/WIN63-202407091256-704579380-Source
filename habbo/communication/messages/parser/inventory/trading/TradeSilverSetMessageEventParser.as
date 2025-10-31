package com.sulake.habbo.communication.messages.parser.inventory.trading {
   import com.sulake.core.communication.messages.IMessageDataWrapper
   import com.sulake.core.communication.messages.IMessageParser

   [SecureSWF(rename="true")]
    public class TradeSilverSetMessageEventParser implements IMessageParser {

        public function TradeSilverSetMessageEventParser() {
            super();
        }
        private var var_563: int;
        private var var_502: int;

        public function get playerSilver(): int {
            return var_563;
        }

        public function get otherPlayerSilver(): int {
            return var_502;
        }

        public function flush(): Boolean {
            var_563 = -1;
            var_502 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_563 = param1.readInteger();
            var_502 = param1.readInteger();
            return true;
        }
    }
}
