package com.sulake.habbo.communication.messages.parser.avatar {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.avatar.class_1717

    [SecureSWF(rename="true")]
    public class class_1450 implements IMessageParser {

        public function class_1450() {
            super();
        }
        private var var_149: int;
        private var var_725: Array;

        public function get outfits(): Array {
            return var_725;
        }

        public function get state(): int {
            return var_149;
        }

        public function flush(): Boolean {
            var_149 = 0;
            var_725 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc4_: int = 0;
            var _loc2_: class_1717 = null;
            var_149 = param1.readInteger();
            var _loc3_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc2_ = new class_1717(param1);
                var_725.push(_loc2_);
                _loc4_++;
            }
            return true;
        }
    }
}
