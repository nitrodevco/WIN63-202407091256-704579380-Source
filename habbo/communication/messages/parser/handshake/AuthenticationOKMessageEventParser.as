package com.sulake.habbo.communication.messages.parser.handshake {
   import com.sulake.core.communication.messages.IMessageDataWrapper
   import com.sulake.core.communication.messages.IMessageParser

   [SecureSWF(rename="true")]
    public class AuthenticationOKMessageEventParser implements IMessageParser {

        public function AuthenticationOKMessageEventParser() {
            super();
            var_361 = [];
        }
        private var var_388: int;
        private var var_361: Array;
        private var var_520: int;

        public function get accountId(): int {
            return var_388;
        }

        public function get suggestedLoginActions(): Array {
            return var_361;
        }

        public function get identityId(): int {
            return var_520;
        }

        public function flush(): Boolean {
            var_388 = -1;
            var_361 = [];
            var_520 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_388 = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_361.push(param1.readShort());
                _loc3_++;
            }
            var_520 = param1.readInteger();
            return true;
        }
    }
}
