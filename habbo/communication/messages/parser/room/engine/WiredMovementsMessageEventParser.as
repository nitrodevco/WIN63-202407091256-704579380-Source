package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.room.utils.Vector3d

    [SecureSWF(rename="true")]
    public class WiredMovementsMessageEventParser implements IMessageParser {

        private static function parseUserMove(param1: IMessageDataWrapper): class_1761 {
            var _loc4_: Number = param1.readInteger();
            var _loc5_: Number = param1.readInteger();
            var _loc12_: Number = param1.readInteger();
            var _loc10_: Number = param1.readInteger();
            var _loc6_: Number = Number(param1.readString());
            var _loc9_: Number = Number(param1.readString());
            var _loc7_: Number = param1.readInteger();
            var _loc11_: Number = param1.readInteger();
            var _loc2_: Number = param1.readInteger();
            var _loc3_: Number = param1.readInteger();
            var _loc8_: Number = param1.readInteger();
            return new class_1761(_loc7_, new Vector3d(_loc4_, _loc5_, _loc6_), new Vector3d(_loc12_, _loc10_, _loc9_), _loc11_ == 0 ? "mv" : "sld", _loc2_, _loc3_, _loc8_);
        }

        private static function parseFurniMove(param1: IMessageDataWrapper): class_1690 {
            var _loc3_: Number = param1.readInteger();
            var _loc4_: Number = param1.readInteger();
            var _loc10_: Number = param1.readInteger();
            var _loc8_: Number = param1.readInteger();
            var _loc5_: Number = Number(param1.readString());
            var _loc7_: Number = Number(param1.readString());
            var _loc6_: Number = param1.readInteger();
            var _loc2_: Number = param1.readInteger();
            var _loc9_: Number = param1.readInteger();
            return new class_1690(_loc6_, new Vector3d(_loc3_, _loc4_, _loc5_), new Vector3d(_loc10_, _loc8_, _loc7_), _loc2_, _loc9_);
        }

        private static function parseWallItemMove(param1: IMessageDataWrapper): class_1676 {
            var _loc4_: Number = param1.readInteger();
            var _loc6_: Boolean = param1.readBoolean();
            var _loc10_: int = param1.readInteger();
            var _loc9_: int = param1.readInteger();
            var _loc7_: int = param1.readInteger();
            var _loc8_: int = param1.readInteger();
            var _loc5_: int = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            var _loc11_: int = param1.readInteger();
            var _loc12_: int = param1.readInteger();
            var _loc3_: int = param1.readInteger();
            return new class_1676(_loc4_, _loc6_, _loc10_, _loc9_, _loc7_, _loc8_, _loc5_, _loc2_, _loc11_, _loc12_, _loc3_);
        }

        private static function parseUserDirUpdate(param1: IMessageDataWrapper): class_1655 {
            var _loc3_: Number = param1.readInteger();
            var _loc2_: Number = param1.readInteger();
            var _loc4_: Number = param1.readInteger();
            return new class_1655(_loc3_, _loc2_, _loc4_);
        }

        public function WiredMovementsMessageEventParser() {
            super();
        }
        private var var_313: Array;
        private var var_334: Array;
        private var var_339: Array;
        private var var_302: Array;

        public function get userMoves(): Array {
            return var_313;
        }

        public function get furniMoves(): Array {
            return var_334;
        }

        public function get wallItemMoves(): Array {
            return var_339;
        }

        public function get userDirectionUpdates(): Array {
            return var_302;
        }

        public function flush(): Boolean {
            var_313 = [];
            var_334 = [];
            var_339 = [];
            var_302 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc4_: int = 0;
            var _loc3_: int = 0;
            if (param1 == null) {
                return false;
            }
            var_313 = [];
            var_334 = [];
            var_339 = [];
            var_302 = [];
            var _loc2_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc2_) {
                _loc3_ = param1.readInteger();
                switch (_loc3_) {
                    case 0:
                        var_313.push(parseUserMove(param1));
                        break;
                    case 1:
                        var_334.push(parseFurniMove(param1));
                        break;
                    case 2:
                        var_339.push(parseWallItemMove(param1));
                        break;
                    case 3:
                        var_302.push(parseUserDirUpdate(param1));
                        break;
                }
                _loc4_++;
            }
            return true;
        }
    }
}
