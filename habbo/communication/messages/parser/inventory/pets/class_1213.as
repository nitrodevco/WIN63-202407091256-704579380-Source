package com.sulake.habbo.communication.messages.parser.inventory.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class class_1213 implements IMessageParser {

        public function class_1213() {
            super();
        }
        protected var var_875: int;
        protected var var_1023: int;
        private var var_171: Map;

        public function get petListFragment(): Map {
            return var_171;
        }

        public function get totalFragments(): int {
            return var_875;
        }

        public function get fragmentNo(): int {
            return var_1023;
        }

        public function flush(): Boolean {
            if (var_171) {
                var_171.dispose();
                var_171 = null;
            }
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc4_: class_1679 = null;
            var_875 = param1.readInteger();
            var_1023 = param1.readInteger();
            var_171 = new Map();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _loc4_ = new class_1679(param1);
                var_171.add(_loc4_.id, _loc4_);
                _loc3_++;
            }
            return true;
        }
    }
}
