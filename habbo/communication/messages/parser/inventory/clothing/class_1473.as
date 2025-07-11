package com.sulake.habbo.communication.messages.parser.inventory.clothing {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1473 implements IMessageParser {

        public function class_1473() {
            super();
        }
        private var var_719: Vector.<int>;
        private var var_690: Vector.<String>;

        public function get figureSetIds(): Vector.<int> {
            return var_719;
        }

        public function get boundFurnitureNames(): Vector.<String> {
            return var_690;
        }

        public function flush(): Boolean {
            var_719 = new Vector.<int>(0);
            var_690 = new Vector.<String>(0);
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_719.push(param1.readInteger());
                _loc3_++;
            }
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_690.push(param1.readString());
                _loc3_++;
            }
            return true;
        }
    }
}
