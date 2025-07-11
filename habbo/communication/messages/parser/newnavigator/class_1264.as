package com.sulake.habbo.communication.messages.parser.newnavigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_1706

    [SecureSWF(rename="true")]
    public class class_1264 implements IMessageParser {

        public function class_1264() {
            super();
        }
        private var var_674: Vector.<class_1706>;

        public function get savedSearches(): Vector.<class_1706> {
            return var_674;
        }

        public function flush(): Boolean {
            var_674 = new Vector.<class_1706>(0);
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_674.push(new class_1706(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
