package com.sulake.habbo.communication.messages.parser.notifications {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1361 implements IMessageParser {

        public function class_1361() {
            super();
        }
        private var var_693: Array;

        public function get messages(): Array {
            return var_693;
        }

        public function flush(): Boolean {
            var_693 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_693.push(param1.readString());
                _loc3_++;
            }
            return true;
        }
    }
}
