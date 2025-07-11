package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_1765

    [SecureSWF(rename="true")]
    public class class_1432 implements IMessageParser {

        public function class_1432() {
            var_136 = [];
            super();
        }
        private var var_136: Array;

        public function flush(): Boolean {
            var_136 = [];
            return true;
        }

        public function getObjectCount(): int {
            return var_136.length;
        }

        public function getObject(param1: int): class_1765 {
            if (param1 < 0 || param1 >= getObjectCount()) {
                return null;
            }
            var _loc2_: class_1765 = var_136[param1] as class_1765;
            if (_loc2_ != null) {
                _loc2_.setReadOnly();
            }
            return _loc2_;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc4_: int = 0;
            var _loc6_: int = 0;
            var _loc2_: String = null;
            var _loc8_: class_1765 = null;
            if (param1 == null) {
                return false;
            }
            var_136 = [];
            var _loc5_: Map = new Map();
            var _loc3_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc6_ = param1.readInteger();
                _loc2_ = param1.readString();
                _loc5_.add(_loc6_, _loc2_);
                _loc4_++;
            }
            var _loc7_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc7_) {
                if ((_loc8_ = class_1642.parseObjectData(param1)) != null) {
                    _loc8_.ownerName = _loc5_.getValue(_loc8_.ownerId);
                    var_136.push(_loc8_);
                }
                _loc4_++;
            }
            return true;
        }
    }
}
