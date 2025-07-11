package com.sulake.habbo.communication.messages.parser.hotlooks {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.hotlooks.class_1636

    [SecureSWF(rename="true")]
    public class class_1519 implements IMessageParser {

        public function class_1519() {
            super();
        }
        private var var_729: Array;

        public function get hotLooks(): Array {
            return var_729;
        }

        public function flush(): Boolean {
            var_729 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_729.push(new class_1636(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
