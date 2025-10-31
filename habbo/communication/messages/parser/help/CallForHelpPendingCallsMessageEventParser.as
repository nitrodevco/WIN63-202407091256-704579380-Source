package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CallForHelpPendingCallsMessageEventParser implements IMessageParser {

        public function CallForHelpPendingCallsMessageEventParser() {
            var_143 = [];
            super();
        }
        private var var_143: Array;

        public function get callArray(): Array {
            return var_143;
        }

        public function get callCount(): int {
            return var_143.length;
        }

        public function flush(): Boolean {
            var_143 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc4_: int = 0;
            var _loc2_: Object = null;
            var_143 = [];
            var _loc3_: int = param1.readInteger();
            while (_loc4_ < _loc3_) {
                _loc2_ = {};
                _loc2_.callId = param1.readString();
                _loc2_.timeStamp = param1.readString();
                _loc2_.message = param1.readString();
                var_143.push(_loc2_);
                _loc4_++;
            }
            return true;
        }
    }
}
