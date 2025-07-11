package com.sulake.habbo.communication.messages.parser.crafting {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1454 implements IMessageParser {

        public function class_1454() {
            var_309 = new Vector.<class_1640>(0);
            super();
        }
        private var var_309: Vector.<class_1640>;

        public function get ingredients(): Vector.<class_1640> {
            return var_309;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_309.push(new class_1640(param1));
                _loc3_++;
            }
            return true;
        }

        public function flush(): Boolean {
            var_309 = new Vector.<class_1640>(0);
            return true;
        }
    }
}
