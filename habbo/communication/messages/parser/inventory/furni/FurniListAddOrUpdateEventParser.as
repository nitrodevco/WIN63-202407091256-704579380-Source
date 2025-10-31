package com.sulake.habbo.communication.messages.parser.inventory.furni {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.class_1707

    [SecureSWF(rename="true")]
    public class FurniListAddOrUpdateEventParser implements IMessageParser {

        public function FurniListAddOrUpdateEventParser() {
            super();
        }
        protected var var_331: Vector.<class_1707>;

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_331 = new Vector.<class_1707>(0);
            var _loc2_: int = 1;
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_331.push(new class_1707(param1));
                _loc3_++;
            }
            return true;
        }

        public function flush(): Boolean {
            var_331 = null;
            return true;
        }

        public function getFurni(): Vector.<class_1707> {
            return var_331;
        }
    }
}
