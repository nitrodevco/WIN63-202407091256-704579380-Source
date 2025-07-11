package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1358 implements IMessageParser {

        public function class_1358() {
            var_310 = [];
            super();
        }
        private var var_394: String = "";
        private var var_310: Array;

        public function get productCode(): String {
            return var_394;
        }

        public function get sellablePalettes(): Array {
            return var_310.slice();
        }

        public function flush(): Boolean {
            var_394 = "";
            var_310 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_394 = param1.readString();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_310.push(new class_1686(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
