package com.sulake.habbo.communication.messages.parser.inventory.bots {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class class_1472 implements IMessageParser {

        public function class_1472() {
            super();
        }

        private var _items: Map;

        public function get items(): Map {
            return _items;
        }

        public function flush(): Boolean {
            if (_items) {
                _items.dispose();
                _items = null;
            }
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc4_: int = 0;
            var _loc2_: class_1726 = null;
            _items = new Map();
            var _loc3_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc2_ = new class_1726(param1);
                _items.add(_loc2_.id, _loc2_);
                _loc4_++;
            }
            return true;
        }
    }
}
