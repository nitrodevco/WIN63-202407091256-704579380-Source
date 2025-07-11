package com.sulake.habbo.communication.messages.parser.nft {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1130 implements IMessageParser {

        public function class_1130() {
            super();
        }
        private var var_261: Vector.<int>;

        public function get chatStyleIds(): Vector.<int> {
            return var_261;
        }

        public function flush(): Boolean {
            var_261 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_261 = new Vector.<int>();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_261.push(param1.readInteger());
                _loc3_ += 1;
            }
            return true;
        }
    }
}
