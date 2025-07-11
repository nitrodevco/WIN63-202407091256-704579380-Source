package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class class_1561 implements IMessageParser {

        public function class_1561() {
            super();
        }
        private var var_187: Map;
        private var var_177: Map;

        public function get urgentData(): Map {
            return var_187;
        }

        public function get normalData(): Map {
            return var_177;
        }

        public function flush(): Boolean {
            if (var_187 != null) {
                var_187.dispose();
            }
            var_187 = null;
            if (var_177 != null) {
                var_177.dispose();
            }
            var_177 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            var _loc5_: String = null;
            var _loc4_: int = 0;
            var _loc3_: int = 0;
            var_187 = new Map();
            var_177 = new Map();
            _loc3_ = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc2_ = param1.readInteger();
                _loc5_ = param1.readString();
                var_187.add(_loc2_, _loc5_);
                _loc4_++;
            }
            _loc3_ = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc2_ = param1.readInteger();
                _loc5_ = param1.readString();
                var_177.add(_loc2_, _loc5_);
                _loc4_++;
            }
            return true;
        }
    }
}
