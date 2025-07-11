package com.sulake.habbo.communication.messages.parser.vault {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1556 implements IMessageParser {

        public function class_1556() {
            var_47 = [];
            super();
        }
        private var var_47: Array;

        public function get data(): Array {
            return var_47;
        }

        public function set data(param1: Array): void {
            var_47 = param1;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_47.push(new class_1713(param1.readByte(), param1.readByte(), param1.readInteger(), param1.readString()));
                _loc3_++;
            }
            return true;
        }

        public function flush(): Boolean {
            var_47 = [];
            return true;
        }
    }
}
