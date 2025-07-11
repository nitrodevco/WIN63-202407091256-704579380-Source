package com.sulake.habbo.communication.messages.parser.newnavigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_1764

    [SecureSWF(rename="true")]
    public class class_1145 implements IMessageParser {

        public function class_1145() {
            super();
        }
        private var var_728: Vector.<class_1764>;

        public function get topLevelContexts(): Vector.<class_1764> {
            return var_728;
        }

        public function flush(): Boolean {
            var_728 = new Vector.<class_1764>(0);
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_728.push(new class_1764(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
