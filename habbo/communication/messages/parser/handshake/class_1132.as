package com.sulake.habbo.communication.messages.parser.handshake {
   import com.sulake.core.communication.messages.IMessageDataWrapper
   import com.sulake.core.communication.messages.IMessageParser

   import flash.utils.Dictionary

   [SecureSWF(rename="true")]
    public class class_1132 implements IMessageParser {

        public function class_1132() {
            super();
        }
        private var var_198: Dictionary;

        public function get accounts(): Dictionary {
            return var_198;
        }

        public function flush(): Boolean {
            if (var_198) {
                var_198 = null;
            }
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_198 = new Dictionary();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_198[param1.readInteger()] = param1.readString();
                _loc3_++;
            }
            return true;
        }
    }
}
