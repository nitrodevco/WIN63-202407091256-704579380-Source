package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1342 implements IMessageParser {

        public function class_1342() {
            super();
        }
        private var var_418: int;
        private var var_121: Array;

        public function get badges(): Array {
            return var_121;
        }

        public function get userId(): int {
            return var_418;
        }

        public function flush(): Boolean {
            var_418 = -1;
            var_121 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc5_: int = 0;
            var _loc2_: int = 0;
            var _loc3_: String = null;
            var_418 = param1.readInteger();
            var _loc4_: int = param1.readInteger();
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                _loc2_ = param1.readInteger();
                _loc3_ = param1.readString();
                var_121.push(_loc3_);
                _loc5_++;
            }
            return true;
        }
    }
}
