package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class class_1405 implements IMessageParser {

        public function class_1405() {
            super();
        }
        private var var_47: Map;

        public function get data(): Map {
            return var_47;
        }

        public function flush(): Boolean {
            if (var_47 != null) {
                var_47.dispose();
            }
            var_47 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            var _loc5_: String = null;
            var _loc4_: int = 0;
            var_47 = new Map();
            var _loc3_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc2_ = param1.readInteger();
                _loc5_ = param1.readString();
                var_47.add(_loc2_, _loc5_);
                _loc4_++;
            }
            return true;
        }
    }
}
