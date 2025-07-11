package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1509 implements IMessageParser {

        public function class_1509() {
            var_253 = new Vector.<class_1661>(0);
            super();
        }
        private var var_253: Vector.<class_1661>;

        public function get collectibleProductItems(): Vector.<class_1661> {
            return var_253;
        }

        public function flush(): Boolean {
            var_253 = new Vector.<class_1661>(0);
            return false;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_253.push(new class_1661(param1));
                _loc3_++;
            }
            return true;
        }

        public function hasData(): Boolean {
            return var_253.length > 0;
        }
    }
}
