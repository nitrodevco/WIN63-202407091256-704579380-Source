package com.sulake.habbo.communication.messages.parser.inventory.furni {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.class_1707

    [SecureSWF(rename="true")]
    public class FurniListEventParser implements IMessageParser {

        public function FurniListEventParser() {
            super();
        }
        protected var var_875: int;
        protected var var_1023: int;
        private var var_179: Map;

        public function get totalFragments(): int {
            return var_875;
        }

        public function get fragmentNo(): int {
            return var_1023;
        }

        public function get furniFragment(): Map {
            return var_179;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc4_: class_1707 = null;
            var_875 = param1.readInteger();
            var_1023 = param1.readInteger();
            var_179 = new Map();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _loc4_ = new class_1707(param1);
                var_179.add(_loc4_.itemId, _loc4_);
                _loc3_++;
            }
            return true;
        }

        public function flush(): Boolean {
            if (var_179) {
                var_179.dispose();
                var_179 = null;
            }
            return true;
        }
    }
}
