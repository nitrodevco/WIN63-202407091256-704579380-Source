package com.sulake.habbo.communication.messages.parser.crafting {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CraftableProductsMessageEventParser implements IMessageParser {

        public function CraftableProductsMessageEventParser() {
            var_225 = new Vector.<class_1649>(0);
            var_219 = new Vector.<String>(0);
            super();
        }
        private var var_225: Vector.<class_1649>;
        private var var_219: Vector.<String>;

        public function get recipeProductItems(): Vector.<class_1649> {
            return var_225;
        }

        public function get usableInventoryFurniClasses(): Vector.<String> {
            return var_219;
        }

        public function flush(): Boolean {
            var_225 = new Vector.<class_1649>(0);
            var_219 = new Vector.<String>(0);
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_225.push(new class_1649(param1));
                _loc3_++;
            }
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_219.push(param1.readString());
                _loc3_++;
            }
            return true;
        }

        public function hasData(): Boolean {
            return var_225.length > 0 || var_219.length > 0;
        }
    }
}
