package com.sulake.habbo.communication.messages.parser.notifications {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class class_1505 implements IMessageParser {

        public function class_1505() {
            super();
        }
        private var var_329: String;

        private var _parameters: Map;

        public function get parameters(): Map {
            return _parameters;
        }

        public function get type(): String {
            return var_329;
        }

        public function flush(): Boolean {
            var_329 = null;
            _parameters = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc5_: String = null;
            var _loc4_: String = null;
            var_329 = param1.readString();
            _parameters = new Map();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _loc5_ = param1.readString();
                _loc4_ = param1.readString();
                _parameters.add(_loc5_, _loc4_);
                _loc3_++;
            }
            return true;
        }
    }
}
