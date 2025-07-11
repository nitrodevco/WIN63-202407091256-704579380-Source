package com.sulake.habbo.communication.messages.parser.newnavigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1590 implements IMessageParser {

        public function class_1590() {
            super();
        }
        private var var_660: Vector.<String>;

        public function get collapsedCategories(): Vector.<String> {
            return var_660;
        }

        public function flush(): Boolean {
            var_660 = new Vector.<String>(0);
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_660.push(param1.readString());
                _loc3_++;
            }
            return true;
        }
    }
}
