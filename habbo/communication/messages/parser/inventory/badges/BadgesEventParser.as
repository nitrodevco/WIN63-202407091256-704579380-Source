package com.sulake.habbo.communication.messages.parser.inventory.badges {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class BadgesEventParser implements IMessageParser {

        public function BadgesEventParser() {
            super();
        }
        protected var var_875: int;
        protected var var_1023: int;
        private var var_172: Map;

        public function get totalFragments(): int {
            return var_875;
        }

        public function get fragmentNo(): int {
            return var_1023;
        }

        public function get currentFragment(): Map {
            return var_172;
        }

        public function flush(): Boolean {
            if (var_172) {
                var_172.dispose();
                var_172 = null;
            }
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            var _loc3_: String = null;
            var _loc4_: int = 0;
            var_875 = param1.readInteger();
            var_1023 = param1.readInteger();
            var_172 = new Map();
            var _loc5_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc5_) {
                _loc2_ = param1.readInteger();
                _loc3_ = param1.readString();
                var_172.add(_loc3_, _loc2_);
                _loc4_++;
            }
            return true;
        }
    }
}
